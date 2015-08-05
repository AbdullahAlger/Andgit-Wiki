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

  end


end