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

require 'spec_helper'

describe Character do
  pending "add some examples to (or delete) #{__FILE__}"
end
