  create_table "invtypematerials", :id => false, :force => true do |t|
    t.integer "typeid",                        :null => false
    t.integer "materialtypeid",                :null => false
    t.integer "quantity",       :default => 0, :null => false
  end

