# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

tables = %w(
  invblueprinttypes
  invcategories
  invgroups
  invmarketgroups
  invtypes
  invtypematerials
)

tables.each { |t|
  File.open("db/eve/#{t}.sql") do |fh|
    buffer = ""
    until fh.eof?
      line = fh.readline
      if line =~ /^\/\*/
        line = nil
      end
      buffer << line if line
      if line =~ /;\n$/
        ActiveRecord::Base.connection.execute(buffer)
        buffer = ""
      end
    end
  end
}