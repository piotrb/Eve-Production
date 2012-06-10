# == Schema Information
#
# Table name: characters
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  charid         :integer
#  pe_skill       :integer
#  industry_skill :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  user_id        :integer
#

class Character < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :charid, :pe_skill, :industry_skill

  def portrait_url(size = :small)
    size = {
      :small => 64,
      :large => 256,
    }[size]
    "http://image.eveonline.com/Character/#{self.charid}_#{size}.jpg"
  end

end
