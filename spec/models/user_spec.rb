# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_code      :string(255)
#  confirmed              :boolean          default(FALSE)
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  image                  :string(255)
#  username               :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

require 'spec_helper'

describe User do
  let(:user) { create(:user) } 
  let(:recipe) { create(:recipe, :with_ingredients, :owned) } 
  # Associations
  it { expect(subject).to have_many(:recipes) }
  it { expect(subject).to have_many(:votes) }
  it { expect(subject).to have_many(:favorites) }
  it { expect(subject).to have_many(:bites) }
  it { expect(subject).to have_many(:favorite_recipes) }
  it { expect(subject).to have_many(:bit_recipes) }

  describe " custom handle accessor" do
    it "should default to user's name if blank" do
      expect(user.read_attribute(:handle)).to be_nil
      expect(user.handle).to eql user.name
    end

    it "should return the handle attribute if it exists" do
      user.handle = "cooldude7"
      expect(user.handle).to eql "cooldude7"
    end
  end

  describe "Voting instance methods," do
    let(:vote_on_recipe) do
      user.vote(recipe, "bites")
      user.vote(recipe, "favorites")
    end
    let(:unvote_on_recipe) do
      user.unvote(recipe, "bites")
      user.unvote(recipe, "favorites")
    end
    before(:each) do
      unless example.metadata[:skip_before]
        user.vote(recipe, "bites")
        user.vote(recipe, "favorites")
      end
    end
    it "should be able to vote on a recipe, if given a proper association", skip_before: true do
      expect { 
        vote_on_recipe
       }.to change { Vote.count }.from(0).to(2)
       expect{ user.vote(recipe, "ingredients") }.to raise_error
    end
    # Voting
    it { expect(recipe.bites.count).to eql 1 }
    it { expect(recipe.favorites.count).to eql 1 }
    # Counter cache columns
    it "should update counter cache columns accordingly" do
      recipe.reload
      expect(recipe.bites_count).to eql 1
      expect(recipe.favorites_count).to eql 1 
      unvote_on_recipe
      recipe.reload
      expect(recipe.bites_count).to eql 0
      expect(recipe.favorites_count).to eql 0 
    end

    # Unvoting
    it { expect { user.unvote(recipe, "bites") }.to change {Vote.count}.from(2).to(1) }
    it { expect { user.unvote(recipe, "bites") }.to change {user.bites.count}.from(1).to(0) }
    it { expect { user.unvote(recipe, "bites") }.to change {user.bit_recipes.count}.from(1).to(0) }

    it "same user should not be able to vote on same recipe twice" do
      a = user.vote(recipe, "bites")
      b = user.vote(recipe, "favorites")
      expect(a).not_to be_valid
      expect(b).not_to be_valid
    end
    it "voted_on? should return the correct value" do
      expect(user.voted_on?(recipe, "bites")).to be_true
      expect(user.voted_on?(recipe, "favorites")).to be_true
      unvote_on_recipe
      expect(user.voted_on?(recipe, "bites")).to be_false
      expect(user.voted_on?(recipe, "favorites")).to be_false
    end
  end
  
end
