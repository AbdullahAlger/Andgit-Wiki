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

  scenario "click button to edit wiki" do
    visit "/wikis/1"
    click_link "Edit"
    fill_in :wiki_title, :with => "Edited Wiki Title"
    fill_in :wiki_body, :with => "Edited Wiki Content"
    click_button "Save"

    expect(page).to have_content "Edited Wiki Title"
    expect(page).to have_content "Edited Wiki Content"
    expect(page).to have_content "Wiki has been updated."
  end

end
