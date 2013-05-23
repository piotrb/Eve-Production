class InvTypeMaterial < ActiveRecord::Base

  self.table_name = "invtypematerials"

  belongs_to :inv_type, :foreign_key => "typeid"
  belongs_to :material, :foreign_key => "materialtypeid", :class_name => "InvType"

end
