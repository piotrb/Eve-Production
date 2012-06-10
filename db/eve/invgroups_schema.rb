  create_table "invgroups", :primary_key => "groupid", :force => true do |t|
    t.integer "categoryid"
    t.string  "groupname",            :limit => 100
    t.string  "description",          :limit => 3000
    t.integer "iconid"
    t.integer "usebaseprice"
    t.integer "allowmanufacture"
    t.integer "allowrecycler"
    t.integer "anchored"
    t.integer "anchorable"
    t.integer "fittablenonsingleton"
    t.integer "published"
  end

  add_index "invgroups", ["categoryid"], :name => "invgroups_ix_category"

