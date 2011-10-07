namespace :eve do

  def info
    h = {
      :base => "Incarna_1.1.45834_db_mysql_v2",
      :tables => %w(
        invblueprinttypes
        invcategories
        invgroups
        invmarketgroups
        invtypes
        invtypematerials
      ),
      :db => {
        :user => "dev",
        :password => "dev",
        :database => "test",
      },
    }
    h[:sql] = h[:base] + ".sql"
    h[:zip] = h[:base] + ".zip"
    h[:lock] = h[:base] + ".lock"
    h
  end

  def conn
    ActiveRecord::Base.connection
  end

  def process_sql_file(fn)
    File.open(fn) do |fh|
      buffer = ""
      until fh.eof?
        line = fh.readline
        line = nil if line =~ /^(\/\*|--|CREATE DATABASE |USE )/
        if line
          buffer << line
          buffer.strip!
        end
        if line =~ /;\n$/
          yield(buffer)
          buffer = ""
        end
      end
    end
  end

  task :extract_seeds => :environment do

    $stdout.sync = true

    file = "#{info[:base]}.zip"

    unless File.exist?(info[:sql])
      puts "unzipping ..."
      sh "unzip #{info[:zip].inspect}"
    end

    # cleanup the test db

    conn.execute "use #{info[:db][:database]}"

    if ENV['RELOAD']

      conn.tables.each { |t|
        puts "dropping table: #{t}"
        conn.drop_table(t)
      }

      puts "pre-processing sql ..."
      total_count = 0
      total_size = File.size(info[:sql])
      size = 0
      last = 0
      process_sql_file(info[:sql]) do |statement|
        size += statement.length
        total_count += 1
        if last < ((size * 10) / total_size)
          print "%d%% ... " % [(size * 100) / total_size]
          last = ((size * 10) / total_size)
        end
      end
      puts

      puts "found #{total_count} statements ..."

      puts "loading sql ..."
      count = 0
      process_sql_file(info[:sql]) do |statement|
        count += 1
        conn.execute(statement)
        if count % (total_count / 10) == 0
          print "%d%% ... " % [(count * 100) / total_count]
        end
      end
      puts

    end

    FileUtils.mkdir_p("db/eve/")

    Dir["db/eve/*"].each { |f|
      File.unlink(f)
    }

    File.open("db/eve/schema.rb", "w") do |schema_handle|

      info[:tables].each { |t|
        puts "extracting table #{t} ..."
        dumper = ActiveRecord::SchemaDumper.send(:new, conn)
        dumper.send(:table, t, schema_handle)
        table = Arel::Table.new(t)
        query = table.project(Arel.sql('*'))
        File.open("db/eve/#{t}.dat", "w") do |th|
          r = conn.execute(query.to_sql)
          r.each { |row|
            th.write(row.to_json + "\n")
          }
        end
      }

    end

  end

  task :clean => :environment do
    # cleanup

    conn.tables.each { |t|
      puts "dropping table: #{t}"
      conn.drop_table(t)
    }

    File.unlink(info[:sql]) if File.exist?(info[:sql])
  end

end