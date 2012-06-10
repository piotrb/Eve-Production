# == Schema Information
#
# Table name: ramtyperequirements
#
#  typeid         :integer         not null
#  activityid     :integer         not null
#  requiredtypeid :integer         not null
#  quantity       :integer
#  damageperjob   :float
#  recycle        :integer
#

class RamTypeRequirement < ActiveRecord::Base

  set_table_name "ramtyperequirements"

  belongs_to :inv_type, :foreign_key => "typeid"
  belongs_to :requirement, :foreign_key => "requiredtypeid", :class_name => "InvType"
  belongs_to :ram_activity, :foreign_key => "activityid"

end
