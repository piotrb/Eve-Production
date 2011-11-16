  create_table "invgroups", :primary_key => "groupid", :force => true do |t|
    t.integer "categoryid",           :limit => 1
    t.string  "groupname",            :limit => 100
    t.string  "description",          :limit => 3000
    t.integer "iconid"
    t.integer "usebaseprice",         :limit => 1
    t.integer "allowmanufacture",     :limit => 1
    t.integer "allowrecycler",        :limit => 1
    t.integer "anchored",             :limit => 1
    t.integer "anchorable",           :limit => 1
    t.integer "fittablenonsingleton", :limit => 1
    t.integer "published",            :limit => 1
  end

  add_index "invgroups", ["categoryid"], :name => "invgroups_ix_category"

