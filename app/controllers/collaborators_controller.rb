class CollaboratorsController < ApplicationController

  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    collaborator = Collaborator.create(user: user, wiki: wiki)

    if collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:error] = "There was an error adding the collaborator. Please try again."
    end
    redirect_to edit_wiki_path wiki

  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.where(user_id: params[:id]).first

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:error] = "There was an error removing the collaborator. Please try again."
    end
    redirect_to edit_wiki_path wiki

  end


end