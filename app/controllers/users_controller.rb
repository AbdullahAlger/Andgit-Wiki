class UsersController < ApplicationController
  def index
    @wikis = current_user.wikis.all
  end
end
