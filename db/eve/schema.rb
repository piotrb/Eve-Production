  create_table "invblueprinttypes", :primary_key => "blueprinttypeid", :force => true do |t|
    t.integer "parentblueprinttypeid"
    t.integer "producttypeid"
    t.integer "productiontime"
    t.integer "techlevel",                :limit => 2
    t.integer "researchproductivitytime"
    t.integer "researchmaterialtime"
    t.integer "researchcopytime"
    t.integer "researchtechtime"
    t.integer "productivitymodifier"
    t.integer "materialmodifier",         :limit => 2
    t.integer "wastefactor",              :limit => 2
    t.integer "maxproductionlimit"
  end

  create_table "invcategories", :primary_key => "categoryid", :force => true do |t|
    t.string  "categoryname", :limit => 100
    t.string  "description",  :limit => 3000
    t.integer "iconid"
    t.integer "published",    :limit => 1
  end

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

  create_table "invmarketgroups", :primary_key => "marketgroupid", :force => true do |t|
    t.integer "parentgroupid",   :limit => 2
    t.string  "marketgroupname", :limit => 100
    t.string  "description",     :limit => 3000
    t.integer "iconid"
    t.integer "hastypes",        :limit => 1
  end

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

  create_table "invtypematerials", :id => false, :force => true do |t|
    t.integer "typeid",                        :null => false
    t.integer "materialtypeid",                :null => false
    t.integer "quantity",       :default => 0, :null => false
  end

  create_table "ramtyperequirements", :id => false, :force => true do |t|
    t.integer "typeid",                      :null => false
    t.integer "activityid",     :limit => 1, :null => false
    t.integer "requiredtypeid",              :null => false
    t.integer "quantity"
    t.float   "damageperjob"
    t.integer "recycle",        :limit => 1
  end

