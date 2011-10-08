# == Schema Information
#
# Table name: invgroups
#
#  groupid              :integer         not null, primary key
#  categoryid           :integer(2)
#  groupname            :string(100)
#  description          :string(3000)
#  iconid               :integer
#  usebaseprice         :integer(2)
#  allowmanufacture     :integer(2)
#  allowrecycler        :integer(2)
#  anchored             :integer(2)
#  anchorable           :integer(2)
#  fittablenonsingleton :integer(2)
#  published            :integer(2)
#

class InvGroup < EveModel

  set_table_name "invgroups"

  set_primary_key "groupid"

  has_many :inv_types, :foreign_key => "groupid"
  belongs_to :inv_category, :foreign_key => "categoryid"

  def self.bad_groups
    [
      186, # wreck
      226, # Large Collidable Object
    ]
  end

end
