# == Schema Information
#
# Table name: blueprints
#
#  id                 :integer         not null, primary key
#  typeid             :integer
#  material_level     :integer
#  productivity_level :integer
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Blueprint do
  pending "add some examples to (or delete) #{__FILE__}"
end
