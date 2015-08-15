require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  context "GET index" do

    it "should show the current_user's wikis" do
      user = create(:user)
      sign_in(user)
      wiki = create(:wiki, user: user)

      get :index

    end

  end

end