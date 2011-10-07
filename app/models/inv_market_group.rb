class InvMarketGroup < EveModel

  set_table_name "invmarketgroups"
  set_primary_key "marketGroupID"

  has_many :item_types, :foreign_key => "marketGroupID"
  belongs_to :parent, :foreign_key => "parentGroupID", :class_name => "InvMarketGroup"

  def full_name
    pieces = []
    pieces << self.marketGroupName
    p = self
    while p = p.parent
      pieces << p.marketGroupName
    end
    pieces.join(" : ")
  end

end
