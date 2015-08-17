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
      params = {wiki: {title: "Angular is fun, except testing it", body: "Angular testing causes brain malfunctions, brain malfunctions"}}

      post :create, params
      expect(response).to have_http_status(:found)

      wiki = Wiki.find_by(title: "Angular is fun, except testing it", body: "Angular testing causes brain malfunctions, brain malfunctions")
      expect(wiki).not_to be_nil
      expect(flash[:notice]).to eq "Wiki was saved."
      expect(response).to redirect_to(wiki_path(wiki))
    end

    it "does not create a wiki if there isn't a title" do
      user = create(:user)
      sign_in(user)
      params = {wiki: {title: "", body: "Angular testing causes brain malfunctions, brain malfunctions"}}
      post :create, params
      expect(Wiki.any?).to eq false
      expect(response).to have_http_status(:ok)
      expect(flash[:error]).to eq "There was an error saving the wiki. Please try again."
    end

    it "does not create a wiki if there isn't a body" do
      user = create(:user)
      sign_in(user)
      params = {wiki: {title: "Angular is fun, except testing it", body: ""}}
      post :create, params
      wiki = Wiki.any?
      expect(wiki).to eq false
      expect(response).to have_http_status(:ok)
      expect(flash[:error]).to eq "There was an error saving the wiki. Please try again."
    end

    it "allows a premium user to create a private wiki" do
      premium_user = create(:user, role: "premium")
      sign_in(premium_user)
      params = {wiki: {title: "Angular is fun, except testing it", body: "Angular testing causes brain malfunctions, brain malfunctions", private: "1"}}
      post :create, params
      expect(response).to have_http_status(:found)
      wiki = Wiki.find_by(title: "Angular is fun, except testing it", body: "Angular testing causes brain malfunctions, brain malfunctions")
      expect(flash[:notice]).to eq "Wiki was saved."
      expect(wiki.private).to eq true
    end

    it "prevents a standard user from creating a private wiki" do
      standard_user = create(:user, role: "standard")
      sign_in(standard_user)

      params = {
        wiki: {
          title: "Angular is fun, except testing it",
          body: "Angular testing causes brain malfunctions, brain malfunctions",
          private: "1"
        }
      }
      post :create, params

      expect(flash[:notice]).to eq "Wiki was saved."
      wiki = Wiki.find_by(title: "Angular is fun, except testing it")
      expect(wiki).not_to be_nil
      expect(response).to redirect_to(wiki_path(wiki))
      expect(wiki.private?).to eq false
    end
  end

  context "PATCH update" do
    it "updates a wiki" do
      user = create(:user)
      sign_in(user)
      wiki = create(:wiki, user: user)
      params = {wiki: {title: "new title", body: "new bodynew bodynew bodynew bodynew body"}, id: wiki.slug}

      patch :update, params
      wiki.reload
      expect(flash[:notice]).to eq "Wiki has been updated."
      expect(response).to redirect_to(wiki_path(wiki))
      expect(response).to have_http_status(:found)
      expect(wiki.title).to eq "new title"
      expect(wiki.body).to eq "new bodynew bodynew bodynew bodynew body"
    end

    it "allows a premium user to privatize a wiki" do
      user = create(:user, role: "premium")
      sign_in(user)
      wiki = create(:wiki, user: user, private: false)
      params = {wiki: {private: "1"}, id: wiki.slug}

      patch :update, params
      wiki.reload
      expect(flash[:notice]).to eq "Wiki has been updated."
      expect(response).to redirect_to(wiki_path(wiki))
      expect(response).to have_http_status(:found)
      expect(wiki.private).to eq true
    end

    it "prevents a standard user from privatizing a wiki" do
      standard_user = create(:user, role: "standard")
      sign_in(standard_user)
      wiki = create(:wiki, user: standard_user, private: false)

      params = {wiki: {private: "1", title: wiki.title, body: wiki.body}, id: wiki.slug}
      patch :update, params

      expect(wiki.reload.private?).to eq false
      expect(flash[:notice]).to eq "Wiki has been updated."
      expect(response).to redirect_to(wiki_path(wiki))
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
