class RamTypeRequirement < ActiveRecord::Base

  set_table_name "ramtyperequirements"

  belongs_to :inv_type, :foreign_key => "typeid"
  belongs_to :requirement, :foreign_key => "requiredtypeid", :class_name => "InvType"
  belongs_to :ram_activity, :foreign_key => "activityid"

end
