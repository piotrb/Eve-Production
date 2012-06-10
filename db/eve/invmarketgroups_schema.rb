  create_table "invmarketgroups", :primary_key => "marketgroupid", :force => true do |t|
    t.integer "parentgroupid"
    t.string  "marketgroupname", :limit => 100
    t.string  "description",     :limit => 3000
    t.integer "iconid"
    t.integer "hastypes"
  end

