# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Location < ActiveRecord::Base

  belongs_to :user
  has_many :prices, :dependent => :destroy

  validates_presence_of :user, :name

  def first
    name
  end

  def last
    id
  end

end
