namespace :eve do

  task :extract_seeds => :environment do

    base = "Incarna_1.1.45834_db_mysql_v2"

    Dir["db/eve/*.sql"].each { |f|
      File.unlink(f)
    }

    tables = %w(
      invblueprinttypes
      invcategories
      invgroups
      invmarketgroups
      invtypes
      invtypematerials
    )

    file = "#{base}.zip"

    extracted = "#{base}.sql"

    unless File.exist?(extracted)
      puts "unzipping ..."
      sh "unzip #{file.inspect}"
    end

    # cleanup the test db

    conn = ActiveRecord::Base.connection

    conn.execute "use test"

    conn.tables.each { |t|
      puts "dropping table: #{t}"
      conn.drop_table(t)
    }

    # undump the sql dump to the test db

    p "extracting dump ..."
    sh "sed -E 's/^(CREATE DATABASE|USE) /-- \1 /' #{extracted} | mysql -u dev -pdev test"

    FileUtils.mkdir_p("db/eve/")

    tables.each { |t|
      puts "extracting table #{t} ..."
      file = "db/eve/#{t}.sql"
      sh "mysqldump -u dev -pdev --skip-extended-insert --compact --compatible=ansi test #{t} > #{file}"
    }

    # cleanup

    conn.tables.each { |t|
      puts "dropping table: #{t}"
      conn.drop_table(t)
    }

    File.unlink(extracted)

  end

end