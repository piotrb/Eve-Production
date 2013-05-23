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
