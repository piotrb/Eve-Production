  create_table "invcategories", :primary_key => "categoryid", :force => true do |t|
    t.string  "categoryname", :limit => 100
    t.string  "description",  :limit => 3000
    t.integer "iconid"
    t.integer "published"
  end

