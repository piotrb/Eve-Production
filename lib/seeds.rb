class Seeds

  class ModelBase < ActiveRecord::Base
    abstract_class = true

    def self.column_map
      @column_map ||= 
      Hash[columns.map { |c| [c.name, c] }]
    end

    def self.column_names
      @column_names ||= 
      columns.map(&:name)
    end

    def self.key_list
      @key_list ||= 
      column_names.map { |column|
        conn.quote_column_name(column)
      }
    end

    def self.conn
      @conn ||=
      connection
    end

    def self.batch_insert(rows)
      return unless rows.length > 0

      sql = ""
      sql << "INSERT INTO #{conn.quote_table_name(table_name)}\n"
      sql << "(#{column_names.join(', ')})\n"
      sql << "VALUES\n"

      i = 0

      rows.each_with_index { |row,ri|
        i = 0
        sql << '('
        sql << row.map { |val|
          v = conn.quote(val, column_map[column_names[i]])
          i += 1
          v
        }.join(', ')
        sql << ')'
        sql << ",\n" unless ri == (rows.length - 1)
      }

      sql << ";"

      conn.execute sql

    end

  end

  def self.tables
    [
      "invblueprinttypes",
      "invcategories",
      "invgroups",
      "invmarketgroups",
      "invtypes",
      "invtypematerials",
      "ramtyperequirements",
      "ramactivities",
    ]
  end

  def self.load_single(table)
    new.load_table(table)
  end

  def self.load_all
    o = new
    tables.each { |t|
      o.load_table(t)
    }
  end

  def conn
    ActiveRecord::Base.connection
  end

  # these are needed to load the table creations
  delegate :create_table,      :to => :conn
  delegate :add_index,         :to => :conn
  delegate :drop_table,        :to => :conn

  def load_table(table)
    puts "loading #{table} ..."

    batch_size = 500

    eval(File.read("db/eve/#{table}_schema.rb"), binding, "db/eve/#{table}_schema.rb", 1)

    t = table

    cols = ActiveRecord::Base.connection.columns(t)
    pk = ActiveRecord::Base.connection.primary_key(t)

    cc = Class.new(ModelBase) do
      set_table_name t
      set_primary_key pk
      attr_accessible cols
    end

    lines = `cat db/eve/#{t}.dat | wc -l`.strip.to_i

    File.open("db/eve/#{t}.dat") do |fh|
      data = []
      flush_data = proc { |n|
        cc.batch_insert(data)
        data = []
        puts "  #{n} (#{n*100 / lines}%) added ..."
      }
      n = 0
      until fh.eof?
        n += 1
        line = fh.readline
        row = JSON.load(line)
        if row[0] == 0
          flush_data[n]
        end
        data << row
        if row[0] == 0
          flush_data[n]
          o = cc.last
          conn.execute("update #{t} set #{pk}=0 where #{pk}=#{o[pk]}") unless o.nil? || o[pk] == 0
        end
        if n % batch_size == 0
          flush_data[n]
        end
      end
      flush_data[n]
    end
  end

end