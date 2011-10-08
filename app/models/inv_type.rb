class InvType < EveModel

  set_table_name "invtypes"
  set_primary_key "typeid"

  scope :items, includes("inv_group").where("invgroups.categoryid in (?)", InvCategory.good_categories).where("invtypes.groupid not in (?)", InvGroup.bad_groups)

  belongs_to :inv_group, :foreign_key => "groupid"
  belongs_to :inv_market_group, :foreign_key => "marketgroupid"

  has_many :inv_type_materials, :foreign_key => "typeid"
  has_one :inv_blueprint_type, :foreign_key => "blueprinttypeid"
  has_one :created_by_blueprint, :foreign_key => "producttypeid", :class_name => "InvBlueprintType"

  has_many :prices, :foreign_key => "typeid"

  def materials
    out = inv_type_materials.to_a
    # if created_by_blueprint.techLevel == 2
    #   out << InvTypeMaterial.new(:material => self, :inv_type => 
    # end
    out
  end

  def cheapest_market_price
    prices.sort_by { |p| p.price }.first
  end

  def actual_cheapest_price
    [
      cheapest_market_price ? [cheapest_market_price.price, cheapest_market_price.location.name] : nil,
      material_price,
      produced_price,
    ].compact.sort_by { |(p,n)| p.to_f }.first
  end

  def produced_price
    if created_by_blueprint
      created_by_blueprint.blueprint.actual_cheapest_price
    end
  end

  def material_price
    unless inv_blueprint_type.product.materials.empty?
      sum = [0,"Mixed"]
      inv_blueprint_type.product.materials.each { |m|
        cp = m.material.actual_cheapest_price
        return nil if cp.nil?
        sum[0] += (m.quantity * cp.first)
      }
      sum
    end if inv_blueprint_type
  end

end
