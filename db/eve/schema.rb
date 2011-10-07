  create_table "invblueprinttypes", :primary_key => "blueprintTypeID", :force => true do |t|
    t.integer "parentBlueprintTypeID"
    t.integer "productTypeID"
    t.integer "productionTime"
    t.integer "techLevel",                :limit => 2
    t.integer "researchProductivityTime"
    t.integer "researchMaterialTime"
    t.integer "researchCopyTime"
    t.integer "researchTechTime"
    t.integer "productivityModifier"
    t.integer "materialModifier",         :limit => 2
    t.integer "wasteFactor",              :limit => 2
    t.integer "maxProductionLimit"
  end

  create_table "invcategories", :primary_key => "categoryID", :force => true do |t|
    t.string  "categoryName", :limit => 100
    t.string  "description",  :limit => 3000
    t.integer "iconID"
    t.integer "published",    :limit => 1
  end

  create_table "invgroups", :primary_key => "groupID", :force => true do |t|
    t.integer "categoryID",           :limit => 1
    t.string  "groupName",            :limit => 100
    t.string  "description",          :limit => 3000
    t.integer "iconID"
    t.integer "useBasePrice",         :limit => 1
    t.integer "allowManufacture",     :limit => 1
    t.integer "allowRecycler",        :limit => 1
    t.integer "anchored",             :limit => 1
    t.integer "anchorable",           :limit => 1
    t.integer "fittableNonSingleton", :limit => 1
    t.integer "published",            :limit => 1
  end

  add_index "invgroups", ["categoryID"], :name => "invGroups_IX_category"

  create_table "invmarketgroups", :primary_key => "marketGroupID", :force => true do |t|
    t.integer "parentGroupID",   :limit => 2
    t.string  "marketGroupName", :limit => 100
    t.string  "description",     :limit => 3000
    t.integer "iconID"
    t.integer "hasTypes",        :limit => 1
  end

  create_table "invtypes", :primary_key => "typeID", :force => true do |t|
    t.integer "groupID",             :limit => 2
    t.string  "typeName",            :limit => 100
    t.string  "description",         :limit => 3000
    t.integer "graphicID"
    t.float   "radius"
    t.float   "mass"
    t.float   "volume"
    t.float   "capacity"
    t.integer "portionSize"
    t.integer "raceID",              :limit => 1
    t.decimal "basePrice",                           :precision => 19, :scale => 4
    t.integer "published",           :limit => 1
    t.integer "marketGroupID",       :limit => 2
    t.float   "chanceOfDuplicating"
    t.integer "iconID"
  end

  add_index "invtypes", ["groupID"], :name => "invTypes_IX_Group"

  create_table "invtypematerials", :id => false, :force => true do |t|
    t.integer "typeID",                        :null => false
    t.integer "materialTypeID",                :null => false
    t.integer "quantity",       :default => 0, :null => false
  end

