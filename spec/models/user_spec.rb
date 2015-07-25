require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = FactoryGirl.create(:user)
  end

  context "#initialize" do

    it "should initialize the role to standard" do
      expect(@user.role).to eq "standard"
    end
  end

  context "role validation" do

    it "should validate whether a user has a role" do
      @user.role = ""
      expect(@user.valid?).to eq false
      expect(@user.errors[:role]).to include "can't be blank"
    end

    it "should have a valid role" do
      @user.role = "foo"
      expect(@user.valid?).to eq false
      expect(@user.errors[:role]).to include /admin|standard|premium/
    end
  end

  context ".upgrade_account" do

    it "should allow standard users to become premium users" do
      @user.upgrade_account
      expect(@user.role).to eq "premium"
    end
  end

  context ".can_privatize_wiki?" do

    it "should allow premium users to privatize wikis" do
      @user.role = "premium"
      wiki = Wiki.new(user_id: @user.id)
      wiki.is_owned_by?(@user)
      expect(@user.can_privatize_wiki?(wiki)).to eq true
    end

    it "should allow admins to privatize wikis" do
      @user.role = "admin"
      wiki = Wiki.new(user_id: @user.id)
      wiki.is_owned_by?(@user)
      expect(@user.can_privatize_wiki?(wiki)).to eq true
    end
  end

  context ".downgrade_account" do

    it "should downgrade a user role from premium to standard" do
      @user.role = "premium"
      @user.downgrade_account
      expect(@user.role).not_to eq "premium"
    end

    it "should not downgrade an admin to a standard user" do
      @user.role = "admin"
      @user.downgrade_account
      expect(@user.role).not_to eq "standard"
    end
  end

end
