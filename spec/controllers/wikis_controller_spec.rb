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
      params = {wiki: {title: "Angular is fun, except testing it", body: "Angular testing causes brain malfunctions"}}

      post :create, params
      expect(response).to have_http_status(:found)

      wiki = Wiki.find_by(title: "Angular is fun, except testing it", body: "Angular testing causes brain malfunctions")

      expect(wiki).not_to be_nil
      expect(flash[:notice]).to eq "Wiki was saved."
      expect(response).to redirect_to(wiki_path(wiki))
    end

    xit "does not create a wiki if there isn't a title" do

    end

    xit "does not create a wiki if there isn't a body" do

    end

    xit "creates a private wiki when checkbox is checked" do

    end
  end

  context "PATCH update" do
    it "updates a wiki" do
      user = create(:user)
      sign_in(user)
      wiki = create(:wiki, user: user)
      params = {wiki: {title: "new title", body: "new body"}, id: wiki.slug}

      patch :update, params
      wiki.reload
      expect(flash[:notice]).to eq "Wiki has been updated."
      expect(response).to redirect_to(wiki_path(wiki))
      expect(response).to have_http_status(:found)
      expect(wiki.title).to eq "new title"
      expect(wiki.body).to eq "new body"
    end

    xit "allows a premium user to privatize a wiki" do
      expect(wiki.private).to eq true
    end

    xit "prevent a standard user from privatizing a wiki" do

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

    xit "does not delete a wiki if the user selects cancel" do

    end
  end


end