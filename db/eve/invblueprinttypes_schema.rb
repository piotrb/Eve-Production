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

