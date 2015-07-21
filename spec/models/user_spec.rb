require 'rails_helper'

RSpec.describe User, type: :model do

  context "#initialize" do

    it "should initialize the role to standard" do
      user = User.new
      expect(user.role).to eq "standard"
    end

  end

  context "role validation" do

    it "should validate whether a user has a role" do
      user = User.new(role: "")
      expect(user.valid?).to eq false
      expect(user.errors[:role]).to include "can't be blank"
    end

    it "should have a valid role" do
      user = User.new(role: "foo")
      expect(user.valid?).to eq false
      expect(user.errors[:role]).to include("admin")
    end

  end

end
