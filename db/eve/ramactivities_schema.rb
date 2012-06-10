  create_table "ramactivities", :primary_key => "activityid", :force => true do |t|
    t.string  "activityname", :limit => 100
    t.string  "iconno",       :limit => 5
    t.string  "description",  :limit => 1000
    t.integer "published"
  end

