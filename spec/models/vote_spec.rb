# == Schema Information
#
# Table name: votes
#
#  id              :integer          not null, primary key
#  recipe_id       :integer          not null
#  user_id         :integer          not null
#  recipe_owner_id :integer          not null
#  type            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Vote do
	shared_examples "a Vote subclass" do |vote, a_param|

		before(:each) do
			
		end
	  
		it "description" do
			puts a_param
		end

	end

	describe Bite do
		it_should_behave_like "a Vote subclass", Bite, 3
	end

	describe Favorite do
		it_should_behave_like "a Vote subclass", Favorite, 2
	end	
end
