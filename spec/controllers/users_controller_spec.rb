require 'spec_helper'

describe UsersController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'bites'" do
    it "returns http success" do
      get 'bites'
      response.should be_success
    end
  end

  describe "GET 'favorites'" do
    it "returns http success" do
      get 'favorites'
      response.should be_success
    end
  end

  describe "GET 'recipes'" do
    it "returns http success" do
      get 'recipes'
      response.should be_success
    end
  end

end
