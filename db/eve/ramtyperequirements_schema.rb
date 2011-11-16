  create_table "ramtyperequirements", :id => false, :force => true do |t|
    t.integer "typeid",                      :null => false
    t.integer "activityid",     :limit => 1, :null => false
    t.integer "requiredtypeid",              :null => false
    t.integer "quantity"
    t.float   "damageperjob"
    t.integer "recycle",        :limit => 1
  end

