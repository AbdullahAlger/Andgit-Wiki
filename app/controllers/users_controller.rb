class UsersController < ApplicationController

  def index
    @wikis = current_user.wikis
  end

  def downgrade
    current_user.downgrade_account
    flash[:notice] = "You're now a standard user."
    redirect_to wikis_path
  end

end
