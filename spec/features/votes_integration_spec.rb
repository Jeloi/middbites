require 'spec_helper'

feature "Voting on a recipe" do

	shared_examples "a Vote subclass" do |vote, a_param|
	  
		it "description" do
		  pending
		end

	end

end

describe Bite do
  it_should_behave_like "a Vote subclass", Bite, 3
end

describe Favorite do
  it_should_behave_like "a Vote subclass", Favorite, 3
end