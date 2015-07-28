require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = create(:user)
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
      expect(@user.errors[:role]).to eq ["should be one of admin, premium, standard"]
    end
  end

  context ".upgrade_account" do

    it "should allow standard user to become premium user" do
      @user.upgrade_account
      expect(@user.role).to eq "premium"
    end

    it "should not allow admin to become premium user" do
      @user.role = "admin"
      @user.upgrade_account
      expect(@user.role).not_to eq "premium"
      expect(@user.role).to eq "admin"
    end
  end

  context ".can_privatize_wiki?" do

    it "should allow premium user to privatize wikis" do
      @user.role = "premium"
      wiki = Wiki.new(user_id: @user.id)
      expect(@user.can_privatize_wiki?(wiki)).to eq true
    end

    it "should allow admins to privatize wikis" do
      @user.role = "admin"
      wiki = Wiki.new(user_id: @user.id)
      expect(@user.can_privatize_wiki?(wiki)).to eq true
    end

    it "should not allow a standard user to privatize wikis" do
      wiki = Wiki.new(user_id: @user.id)
      expect(@user.can_privatize_wiki?(wiki)).to eq false
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

  context ".make_wikis_public" do

    it "should change private wikis to public wikis" do
      create_list(:wiki, 2, private: true, user: @user)
      @user.make_wikis_public
      expect(@user.wikis.first.private?).to eq false
      expect(@user.wikis.last.private?).to eq false
    end

  end

  context ".can_manage_collaborators?" do

    it "should allow private users to have collaborators" do
      @user.role = "premium"
      create_list(:wiki, 1, private: true, user: @user)
      collab = @user.can_manage_collaborators?(@user.wikis.first)
      expect(collab).to eq true
    end

    it "should allow admin users to have collaborators" do
      @user.role = "admin"
      create_list(:wiki, 1, private: true, user: @user)
      collab = @user.can_manage_collaborators?(@user.wikis.first)
      expect(collab).to eq true
    end

    it "should not allow standard users to have collaborators" do
      @user.role = "standard"
      create_list(:wiki, 1, private: true, user: @user)
      collab = @user.can_manage_collaborators?(@user.wikis.first)
      expect(collab).to eq false
    end
  end

end
