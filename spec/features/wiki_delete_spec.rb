require 'rails_helper'

feature '[[create wikis]]' do

  before(:each) do
    user = FactoryGirl.create(:user, :role => "standard")
    user.save
    login_as(user, :scope => :user)
    visit "/wikis"
    click_link("Create Wiki")
    visit "/wikis/new"
    fill_in :wiki_title, :with => "New Wiki Title"
    fill_in :wiki_body, :with => "This is some content in the wiki."
    click_button "Save"
  end

  scenario "click button to delete wiki" do
    visit "/wikis/1"
    click_link "Delete"
    expect(page).to have_content "\"New Wiki Title\" was deleted."
  end

end
