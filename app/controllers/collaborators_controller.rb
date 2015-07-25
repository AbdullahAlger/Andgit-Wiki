class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
    authorize @collaborator

    if @collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:notice] = "There was an error adding the collaborator. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    authorize @collaborator

    if @collaborator.destory
      flash[:notice] = "Collaborator removed."
    else
      flash[:notice] = "There was an error removing the collaborator. Please try again."
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id)
  end

end