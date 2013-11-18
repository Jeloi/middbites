# == Schema Information
#
# Table name: tags
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  tag_category_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Tag do
  
  # Associations
  it { expect(subject).to have_many(:recipes) }
  it { expect(subject).to have_many(:taggings) }
end
