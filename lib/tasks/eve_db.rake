namespace :eve do

  def info
    h = {
      :base => "Incarna_1.1.45834_db_mysql_v2",
      :tables => %w(
        invBlueprintTypes
        invCategories
        invGroups
        invMarketGroups
        invTypes
        invTypeMaterials
        ramTypeRequirements
        ramActivities
      ),
      # invMetaGroups
      # invMetaTypes
      # invNames
      # invItems
      # invPositions
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

  def dump_table_schema(table)
    File.open("db/eve/#{table.downcase}_schema.rb", "w") do |schema_handle|

      buffer = StringIO.new

      dumper = ActiveRecord::SchemaDumper.send(:new, conn)
      dumper.send(:table, table, buffer)

      buffer.rewind

      schema_handle << buffer.read.downcase

    end
  end

  task :download do
    version = "inferno-1.0_70633"
    Dir.chdir("tmp") do
      info[:tables].each { |table|
        fn = "#{table}.sql.bz2"
        url = "http://evedump.icyone.net/#{version}/bzip2/#{fn}"
        puts "Checking #{table} ..."
        length = `curl -s --head #{url.inspect}`.split("\n").grep(/Content-Length/).first.strip[/\d+$/].to_i
        if File.exist?(fn) && File.stat(fn).size != length
          puts "  File size doesn't match, downloading ..."
          sh "wget -cnv #{url.inspect}"
        end
        unless File.exist?(fn)
          puts "  File not found, downloading ..."
          sh "wget -nv #{url.inspect}"
        end
      }
    end
  end

  task :ensure_extracted_db do

    raise "must run in RAILS_ENV=dump" unless Rails.env.dump?

    $stdout.sync = true

    file = "#{info[:base]}.zip"

    info[:tables].each { |table|
      unless File.exist?("tmp/#{table}.sql")
        puts "unzipping #{table}"
        sh "bunzip2 tmp/#{table}.sql.bz2"
      end
    }

    # cleanup the test db

    conn.execute "use #{info[:db][:database]}"
  end

  task :extract_seeds => [:environment, :ensure_extracted_db] do

    if ENV['RELOAD']

      conn.tables.each { |t|
        puts "dropping table: #{t}"
        conn.drop_table(t)
      }

      info[:tables].each { |table|
        puts "processing table: #{table} ..."
        # puts "  pre-processing sql ..."
        # total_count = 0
        fn = "tmp/#{table}.sql"
        # total_size = File.size(fn)
        # size = 0
        # last = 0
        # process_sql_file(fn) do |statement|
        #   size += statement.length
        #   total_count += 1
        #   if last < ((size * 10) / total_size)
        #     print "  %d%% ... " % [(size * 100) / total_size]
        #     last = ((size * 10) / total_size)
        #   end
        # end
        # puts
        # puts "  found #{total_count} statements ..."
        puts "  loading sql ..."
        count = 0
        process_sql_file(fn) do |statement|
          count += 1
          conn.execute(statement)
          # if count % (total_count / 10) == 0
            print "  %i ... " % [count]
          # end
        end
        puts
      }

    end

    FileUtils.mkdir_p("db/eve/")

    Dir["db/eve/*"].each { |f|
      File.unlink(f)
    }

    info[:tables].each { |t|
      puts "extracting table #{t} ..."
      dump_table_schema(t)
      table = Arel::Table.new(t)
      query = table.project(Arel.sql('*'))
      File.open("db/eve/#{t.downcase}.dat", "w") do |th|
        r = conn.execute(query.to_sql)
        r.each { |row|
          th.write(row.to_json + "\n")
        }
      end
    }

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