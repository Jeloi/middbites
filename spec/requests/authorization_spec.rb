require 'spec_helper'
require "set"

describe "Authorization" do
	
	# shared examples must be loaded before the contexts that use them
	shared_examples "not authorized" do
		describe "description" do
			
		end
	end


	describe "as correct user" do
		
	end
	
	describe "user not signed in" do
		include_examples "not authorized"

	end

	describe "as wrong user" do
		include_examples "not authorized"
		
	end



end


