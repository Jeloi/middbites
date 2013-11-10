require 'spec_helper'

describe Tag do
  
  # Associations
  it { expect(subject).to have_many(:recipes) }
  it { expect(subject).to have_many(:taggings) }
end
