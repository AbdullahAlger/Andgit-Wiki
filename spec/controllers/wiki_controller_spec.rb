require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  before(:all) do
    @user = create(:user)
  end

  context "GET new" do
    it "assigns a blank wiki to the view" do
      get :new
      expect(assigns(:wiki)).to be_a_new(Wiki)
    end
    #this doesn't work yet
  end


end