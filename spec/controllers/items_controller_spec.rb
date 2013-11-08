require 'spec_helper'

describe ItemsController do

  describe "GET 'all'" do
    it "returns http success" do
      get 'all'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'item_category'" do
    it "returns http success" do
      get 'item_category'
      response.should be_success
    end
  end

end
