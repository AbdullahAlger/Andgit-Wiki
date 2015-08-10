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

  context "GET show" do
    it "shows a wiki" do
      user = create(:user)
      sign_in(user)
      wiki = create(:wiki, user: user)

      get :show, id: wiki
      expect(assigns(:wiki)).to eq(wiki)
      expect(response).to have_http_status(:ok)
      expect(Wiki.exists?).to eq(true)
      expect(response).to render_template("show")
    end
  end

  context "POST create" do
    it "creates a wiki" do
      user = create(:user)
      sign_in(user)
      params = {wiki: {title: "valid title", body: "valid body"}}

      post :create, id: {wiki: {id: 1}}, wiki: params
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(wiki_path)
    end
  end

  context "PATCH update" do
    xit "updates a wiki" do
      user = create(:user)
      sign_in(user)
      wiki = create(:wiki, user: user)

      patch :update, id: wiki.id, wiki: {body: wiki}
      expect(response).to have_http_status(:found)
    end
  end

  context "DELETE wiki" do
    it "deletes a wiki" do
      user = create(:user)
      sign_in(user)
      wiki = create(:wiki, user: user)

      delete :destroy, id: wiki.id
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(wikis_path)
      expect(Wiki.exists?(wiki.id)).to eq(false)
    end
  end


end