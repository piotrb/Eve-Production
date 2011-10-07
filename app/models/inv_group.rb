class InvGroup < EveModel

  set_table_name "invgroups"

  set_primary_key "groupID"

  has_many :inv_types, :foreign_key => "groupID"
  belongs_to :inv_category, :foreign_key => "categoryID"

  def self.bad_groups
    [
      186, # wreck
      226, # Large Collidable Object
    ]
  end

end