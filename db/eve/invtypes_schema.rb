  create_table "invtypes", :primary_key => "typeid", :force => true do |t|
    t.integer "groupid",             :limit => 2
    t.string  "typename",            :limit => 100
    t.string  "description",         :limit => 3000
    t.integer "graphicid"
    t.float   "radius"
    t.float   "mass"
    t.float   "volume"
    t.float   "capacity"
    t.integer "portionsize"
    t.integer "raceid",              :limit => 1
    t.decimal "baseprice",                           :precision => 19, :scale => 4
    t.integer "published",           :limit => 1
    t.integer "marketgroupid",       :limit => 2
    t.float   "chanceofduplicating"
    t.integer "iconid"
  end

  add_index "invtypes", ["groupid"], :name => "invtypes_ix_group"

