class Profile

  include ActiveModel::Model
  extend ActiveModel::Naming

  def self.from(user)
    self.new(user)
  end

  def initialize(user)
    @user = user
  end

  delegate :name, :name=, :to => :'@user'
  delegate :username, :username=, :to => :'@user'

  def pairing
    "%s: %s" % [@user.provider, @user.uid] if @user.provider
  end

  def has_password?
    @user.password_digest.present?
  end

  def persisted?
    true
  end

  def update(params)
    @user.update_attributes(params)
  end

end
