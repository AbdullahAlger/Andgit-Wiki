require 'rails_helper'

RSpec.describe WikisController, :type => :controller do

  context "GET index" do

    it "should have a user who is signed in" do
      get :index
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_url)
    end

    it "renders the index template" do
      user = create(:user)
      sign_in(user)
      get :index
      expect(response).to render_template("index")
    end
  end

  context "GET new" do
    it "assigns a new wiki object" do
      user = create(:user)
      sign_in(user)
      get :new
      expect(assigns(:wiki)).to be_a_new(Wiki)
    end
  end

  context "Get show" do

  end

  context "POST create" do

  end

  context "Get edit" do

  end

  context "PATCH update" do

  end

  context "Delete wiki" do

  end


end