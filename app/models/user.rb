# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base

  has_many :locations, :dependent => :destroy
  has_many :characters, :dependent => :destroy
  has_many :prices, :through => :locations
  has_many :blueprints, :dependent => :destroy

  def self.create_with_omniauth(auth, profile)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = profile["name"]
    end
  end

end
