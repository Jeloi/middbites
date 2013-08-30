require "spec_helper"

describe RecipesController do
  describe "routing" do

    it "routes to #index" do
      get("/recipes").should route_to("recipes#index")
    end

    it "routes to #new" do
      get("/recipes/create").should route_to("recipes#new")
    end

    describe "routes to #show" do
      before(:each) do
        create(:recipe)
      end
      it {expect(get("/recipes/1-the-classic")).to route_to("recipes#show", :id => "1")}
      it {expect(get("/recipes/1")).to route_to("recipes#show", :id => "1")}
    end

    it "routes to #edit" do
      get("/recipes/1/edit").should route_to("recipes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recipes").should route_to("recipes#create")
    end

    it "routes to #update" do
      put("/recipes/1").should route_to("recipes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recipes/1").should route_to("recipes#destroy", :id => "1")
    end

  end
end
