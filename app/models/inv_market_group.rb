class InvMarketGroup < ActiveRecord::Base

  self.table_name = "invmarketgroups"
  self.primary_key = "marketgroupid"

  has_many :item_types, :foreign_key => "marketgroupid"
  belongs_to :parent, :foreign_key => "parentgroupid", :class_name => "InvMarketGroup"

  def full_name
    pieces = []
    pieces << self.marketgroupname
    p = self
    while p = p.parent
      pieces << p.marketgroupname
    end
    pieces.join(" : ")
  end

end
