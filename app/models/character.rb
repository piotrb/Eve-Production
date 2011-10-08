# == Schema Information
#
# Table name: characters
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  charid         :integer
#  pe_skill       :integer
#  industry_skill :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Character < ActiveRecord::Base

  def portrait_url(size = :small)
    size = {
      :small => 64,
      :large => 256,
    }[size]
    "http://image.eveonline.com/Character/#{self.charid}_#{size}.jpg"
  end

end
