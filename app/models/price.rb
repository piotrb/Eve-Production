# == Schema Information
#
# Table name: prices
#
#  id          :integer         not null, primary key
#  price       :float
#  typeid      :integer
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Price < ActiveRecord::Base

  belongs_to :location

  belongs_to :inv_type, :class_name => "InvType", :foreign_key => "typeid", :primary_key => "typeid"

  validates_presence_of :location

  scope :for, proc { |item|
    where(:typeid => item.typeid)
  }

end
