require 'rails_helper'

RSpec.describe CollaboratorsController, :type => :controller do

  context "DELETE destroy" do

    it "denies access to anonymous users" do
      user = create(:user)
      wiki = create(:wiki)
      collaborator = create(:collaborator, user: user, wiki: wiki)
      params = {wiki_id: wiki.id, id: user.id}

      delete :destroy, params
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
      expect(Collaborator.exists?(collaborator.id)).to eq(true)
    end

    it "should not allow an attacker to delete a victim's collaborator" do
      attacker = create(:user)
      victim = create(:user)
      wiki = create(:wiki, user: victim)
      collaborator = create(:collaborator, wiki: wiki)
      params = {wiki_id: wiki.id, id: collaborator.user.id}

      sign_in(attacker)

      expect do
        delete :destroy, params
      end.to raise_error ActiveRecord::RecordNotFound

      expect(Collaborator.exists?(collaborator.id)).to eq(true)
    end

    it "a user can delete their collaborators" do
      user = create(:user)
      wiki = create(:wiki, user: user)
      collaborator = create(:collaborator, wiki: wiki)
      params = {wiki_id: wiki.id, id: collaborator.user.id}

      sign_in(user)

      delete :destroy, params
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(edit_wiki_path wiki)
      expect(Collaborator.exists?(collaborator.id)).to eq(false)
    end

  end


end