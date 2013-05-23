class Price < ActiveRecord::Base

  belongs_to :location

  belongs_to :inv_type, :class_name => "InvType", :foreign_key => "typeid", :primary_key => "typeid"

  validates_presence_of :location

  scope :for, proc { |item|
    where(:typeid => item.typeid)
  }

end
