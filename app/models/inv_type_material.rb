class InvTypeMaterial < EveModel

  set_table_name "invtypematerials"

  belongs_to :inv_type, :foreign_key => "typeID"
  belongs_to :material, :foreign_key => "materialTypeID", :class_name => "InvType"

end
