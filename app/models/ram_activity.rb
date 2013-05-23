class RamActivity < ActiveRecord::Base

  self.table_name = "ramactivities"

#  belongs_to :inv_type, :foreign_key => "typeid"
#  belongs_to :requirement, :foreign_key => "requiredtypeid", :class_name => "InvType"

end
