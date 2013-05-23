class Character < ActiveRecord::Base

  belongs_to :user

  def portrait_url(size = :small)
    size = {
      :small => 64,
      :large => 256,
    }[size]
    "http://image.eveonline.com/Character/#{self.charid}_#{size}.jpg"
  end

end
