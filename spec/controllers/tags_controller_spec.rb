require 'spec_helper'

describe TagsController do

  describe "GET 'all_tags'" do
    it "returns http success" do
      get 'all_tags'
      response.should be_success
    end
  end

  describe "GET 'grouped_tags'" do
    it "returns http success" do
      get 'grouped_tags'
      response.should be_success
    end
  end

end
