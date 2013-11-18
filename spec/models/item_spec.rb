# == Schema Information
#
# Table name: items
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  item_category_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Item do
  pending "add some examples to (or delete) #{__FILE__}"
end
