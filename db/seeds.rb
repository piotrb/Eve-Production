# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

tables = [
  "invblueprinttypes",
  "invcategories",
  "invgroups",
  "invmarketgroups",
  "invtypes",
  "invtypematerials",
  "ramtyperequirements",
]

def create_table(*p, &b)
  ActiveRecord::Base.connection.create_table(*p, &b)
end

def add_index(*p)
  ActiveRecord::Base.connection.add_index(*p)
end

$stdout.sync = true

load("db/eve/schema.rb")

tables.each { |t|
  puts "loading #{t} ..."

  pk = ActiveRecord::Base.connection.primary_key(t)
  cols = ActiveRecord::Base.connection.columns(t)

  cc = Class.new(ActiveRecord::Base) do
    set_table_name t
    set_primary_key pk
    attr_accessible cols
  end

  lines = `cat db/eve/#{t}.dat | wc -l`.strip.to_i

  File.open("db/eve/#{t}.dat") do |fh|
    data = []
    flush_data = proc { |n|
      cc.import cc.columns.map(&:name), data
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
        ActiveRecord::Base.connection.execute("update #{t} set #{pk}=0 where #{pk}=#{o[pk]}") unless o.nil? || o[pk] == 0
      end
      if n % 100 == 0
        flush_data[n]
      end
    end
    flush_data[n]
  end
}