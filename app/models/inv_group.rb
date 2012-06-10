# == Schema Information
#
# Table name: invgroups
#
#  groupid              :integer         not null, primary key
#  categoryid           :integer
#  groupname            :string(100)
#  description          :string(3000)
#  iconid               :integer
#  usebaseprice         :integer
#  allowmanufacture     :integer
#  allowrecycler        :integer
#  anchored             :integer
#  anchorable           :integer
#  fittablenonsingleton :integer
#  published            :integer
#

class InvGroup < ActiveRecord::Base

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
