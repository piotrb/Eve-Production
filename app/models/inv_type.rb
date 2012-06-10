# == Schema Information
#
# Table name: invtypes
#
#  typeid              :integer         not null, primary key
#  groupid             :integer
#  typename            :string(100)
#  description         :string(3000)
#  radius              :float
#  mass                :float
#  volume              :float
#  capacity            :float
#  portionsize         :integer
#  raceid              :integer
#  baseprice           :decimal(19, 4)
#  published           :integer
#  marketgroupid       :integer
#  chanceofduplicating :float
#  iconid              :integer
#

class InvType < ActiveRecord::Base

  set_table_name "invtypes"
  set_primary_key "typeid"

  scope :items, includes("inv_group").where("invgroups.categoryid in (?)", InvCategory.good_categories).where("invtypes.groupid not in (?)", InvGroup.bad_groups)

  belongs_to :inv_group, :foreign_key => "groupid"
  belongs_to :inv_market_group, :foreign_key => "marketgroupid"

  has_many :inv_type_materials, :foreign_key => "typeid"
  has_one :inv_blueprint_type, :foreign_key => "blueprinttypeid"
  has_one :created_by_blueprint, :foreign_key => "producttypeid", :class_name => "InvBlueprintType"
  has_many :ram_type_requirements, :foreign_key => "typeid"

  def prices_for(user)
    user ? user.prices.for(self) : Price.where("false")
  end

  def materials
    out = inv_type_materials.to_a
    # if created_by_blueprint.techLevel == 2
    #   out << InvTypeMaterial.new(:material => self, :inv_type => 
    # end
    out
  end

  def cheapest_market_price_for(user)
    prices_for(user).sort_by { |p| p.price }.first
  end

  def actual_cheapest_price_for(user)
    cmp = cheapest_market_price_for(user)
    [
      cmp ? [cmp.price, cmp.location.name] : nil,
      material_price_for(user),
      produced_price_for(user),
    ].compact.sort_by { |(p,n)| p.to_f }.first
  end

  def produced_price_for(user)
    if created_by_blueprint
      created_by_blueprint.blueprint.actual_cheapest_price_for(user)
    end
  end

  def material_price_for(user)
    unless inv_blueprint_type.product.materials.empty?
      sum = [0,"Mixed"]
      inv_blueprint_type.product.materials.each { |m|
        cp = m.material.actual_cheapest_price_for(user)
        return nil if cp.nil?
        sum[0] += (m.quantity * cp.first)
      }
      sum
    end if inv_blueprint_type
  end

end
