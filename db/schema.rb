# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20111009024041) do

  create_table "blueprints", :force => true do |t|
    t.integer  "typeid"
    t.integer  "material_level"
    t.integer  "productivity_level"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "charid"
    t.integer  "pe_skill"
    t.integer  "industry_skill"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
  end

  add_index "characters", ["user_id"], :name => "index_characters_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "locations", ["user_id"], :name => "index_locations_on_user_id"

  create_table "prices", :force => true do |t|
    t.float    "price"
    t.integer  "typeid"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "prices", ["location_id"], :name => "index_prices_on_location_id"
  add_index "prices", ["typeid"], :name => "index_prices_on_typeid"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
