class Location < ActiveRecord::Base
  def first
    name
  end
  def last
    id
  end
end
