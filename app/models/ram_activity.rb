# == Schema Information
#
# Table name: ramactivities
#
#  activityid   :integer         not null, primary key
#  activityname :string(100)
#  iconno       :string(5)
#  description  :string(1000)
#  published    :integer
#

class RamActivity < ActiveRecord::Base

  set_table_name "ramactivities"

#  belongs_to :inv_type, :foreign_key => "typeid"
#  belongs_to :requirement, :foreign_key => "requiredtypeid", :class_name => "InvType"

end
