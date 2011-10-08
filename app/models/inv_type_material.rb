# == Schema Information
#
# Table name: invtypematerials
#
#  typeid         :integer         not null
#  materialtypeid :integer         not null
#  quantity       :integer         default(0), not null
#

class InvTypeMaterial < ActiveRecord::Base

  set_table_name "invtypematerials"

  belongs_to :inv_type, :foreign_key => "typeid"
  belongs_to :material, :foreign_key => "materialtypeid", :class_name => "InvType"

end
