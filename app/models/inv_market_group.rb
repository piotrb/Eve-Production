# == Schema Information
#
# Table name: invmarketgroups
#
#  marketgroupid   :integer         not null, primary key
#  parentgroupid   :integer(2)
#  marketgroupname :string(100)
#  description     :string(3000)
#  iconid          :integer
#  hastypes        :integer(2)
#

class InvMarketGroup < ActiveRecord::Base

  set_table_name "invmarketgroups"
  set_primary_key "marketgroupid"

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
