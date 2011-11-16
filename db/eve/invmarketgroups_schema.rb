  create_table "invmarketgroups", :primary_key => "marketgroupid", :force => true do |t|
    t.integer "parentgroupid",   :limit => 2
    t.string  "marketgroupname", :limit => 100
    t.string  "description",     :limit => 3000
    t.integer "iconid"
    t.integer "hastypes",        :limit => 1
  end

