class InvBlueprintType < EveModel

  set_table_name "invblueprinttypes"
  set_primary_key "blueprintTypeID"

  belongs_to :blueprint, :class_name => "InvType", :foreign_key => "blueprintTypeID"
  belongs_to :product,   :class_name => "InvType", :foreign_key => "productTypeID"

  belongs_to :parent_blueprint, :class_name => "InvBlueprintType", :foreign_key => "parentBlueprintTypeID"
  has_many :child_blueprints, :class_name => "InvBlueprintType", :foreign_key => "parentBlueprintTypeID"

end
