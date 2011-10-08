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
end
