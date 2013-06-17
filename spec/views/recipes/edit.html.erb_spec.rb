require 'spec_helper'

describe "recipes/edit" do
  before(:each) do
    @recipe = assign(:recipe, stub_model(Recipe,
      :directions => "MyText",
      :references => "",
      :references => ""
    ))
  end

  it "renders the edit recipe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recipe_path(@recipe), "post" do
      assert_select "textarea#recipe_directions[name=?]", "recipe[directions]"
      assert_select "input#recipe_references[name=?]", "recipe[references]"
      assert_select "input#recipe_references[name=?]", "recipe[references]"
    end
  end
end
