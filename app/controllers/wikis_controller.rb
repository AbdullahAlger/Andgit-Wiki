class WikisController < ApplicationController

  before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = current_user.wikis.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build
    @wiki.attributes = wiki_params(@wiki)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params(@wiki))
      flash[:notice] = "Wiki has been updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted."
      redirect_to @wiki
    else
      flash[:error] = "There was an error deleting this wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params(wiki)
    permitted_attributes = [:title, :body]
    permitted_attributes << :private if current_user.can_privatize_wiki?(wiki)
    params.require(:wiki).permit(permitted_attributes)
  end
end
