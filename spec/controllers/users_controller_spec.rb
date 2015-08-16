require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  context "GET index" do

    it "should show the current_user's wikis" do
      user = create(:user)
      sign_in(user)
      get :index
      expect(response).to render_template("index")
    end

    it "should have wikis owned by the current user only" do
      user = create(:user)
      diff_user = create(:user)
      sign_in(user)
      wiki_user = create(:wiki, user: user)
      wiki_diff_user = create(:wiki, user: diff_user)

      get :index
      expect(assigns(:wikis)).to eq([wiki_user])
      expect(assigns(:wikis)).not_to eq([wiki_diff_user])
    end
  end

end