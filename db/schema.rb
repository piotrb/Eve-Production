# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111008202125) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "charid"
    t.integer  "pe_skill"
    t.integer  "industry_skill"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer "published",    :limit => 2
  end

  create_table "invgroups", :primary_key => "groupid", :force => true do |t|
    t.integer "categoryid",           :limit => 2
    t.string  "groupname",            :limit => 100
    t.string  "description",          :limit => 3000
    t.integer "iconid"
    t.integer "usebaseprice",         :limit => 2
    t.integer "allowmanufacture",     :limit => 2
    t.integer "allowrecycler",        :limit => 2
    t.integer "anchored",             :limit => 2
    t.integer "anchorable",           :limit => 2
    t.integer "fittablenonsingleton", :limit => 2
    t.integer "published",            :limit => 2
  end

  add_index "invgroups", ["categoryid"], :name => "invgroups_ix_category"

  create_table "invmarketgroups", :primary_key => "marketgroupid", :force => true do |t|
    t.integer "parentgroupid",   :limit => 2
    t.string  "marketgroupname", :limit => 100
    t.string  "description",     :limit => 3000
    t.integer "iconid"
    t.integer "hastypes",        :limit => 2
  end

  create_table "invtypematerials", :id => false, :force => true do |t|
    t.integer "typeid",                        :null => false
    t.integer "materialtypeid",                :null => false
    t.integer "quantity",       :default => 0, :null => false
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
    t.integer "raceid",              :limit => 2
    t.decimal "baseprice",                           :precision => 19, :scale => 4
    t.integer "published",           :limit => 2
    t.integer "marketgroupid",       :limit => 2
    t.float   "chanceofduplicating"
    t.integer "iconid"
  end

  add_index "invtypes", ["groupid"], :name => "invtypes_ix_group"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", :force => true do |t|
    t.float    "price"
    t.integer  "typeid"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["location_id"], :name => "index_prices_on_location_id"
  add_index "prices", ["typeid"], :name => "index_prices_on_typeid"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
