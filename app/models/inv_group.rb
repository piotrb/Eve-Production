class InvGroup < ActiveRecord::Base

  self.table_name = "invgroups"
  self.primary_key = "groupid"

  has_many :inv_types, :foreign_key => "groupid"
  belongs_to :inv_category, :foreign_key => "categoryid"

  def self.bad_groups
    [
      186, # wreck
      226, # Large Collidable Object
    ]
  end

end
