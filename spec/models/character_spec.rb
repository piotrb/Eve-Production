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

require 'spec_helper'

describe Character do
  pending "add some examples to (or delete) #{__FILE__}"
end
