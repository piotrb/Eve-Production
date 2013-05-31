class User < ActiveRecord::Base

  has_secure_password

  has_many :locations, :dependent => :destroy
  has_many :characters, :dependent => :destroy
  has_many :prices, :through => :locations
  has_many :blueprints, :dependent => :destroy

  validate :username, :unique => true

  def self.create_with_omniauth(auth, profile)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = profile["name"]
      user.password = SecureRandom.hex(12)
      user.password_confirmation = user.password
    end
  end

end
