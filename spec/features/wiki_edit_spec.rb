require 'rails_helper'

feature '[[edit wikis]]' do

  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
    visit "/wikis"
    click_link("Create wiki")
    fill_in :wiki_title, :with => "New Wiki Title"
    fill_in :wiki_body, :with => "This is some content in the wiki."
    click_button "Save"
  end

  scenario "click button to edit wiki" do
    click_link "Edit"
    fill_in :wiki_title, :with => "Edited Wiki Title"
    fill_in :wiki_body, :with => "Edited Wiki ContentEdited Wiki Content Edited Wiki Content"
    click_button "Save"

    expect(page).to have_content "Edited Wiki Title"
    expect(page).to have_content "Edited Wiki ContentEdited Wiki Content Edited Wiki Content"
    expect(page).to have_content "Wiki has been updated."
  end

  scenario "does not lose edited information when a validation error appears" do
    click_link "Edit"
    fill_in :wiki_title, :with => "Edited Wiki Title"
    fill_in :wiki_body, :with => "Short content"
    click_button "Save"

    expect(page).to have_content "There was an error saving the wiki. Please try again."
    expect(page).to have_field :wiki_title, with: "Edited Wiki Title"
    expect(page).to have_field :wiki_body, with: "Short content"
  end

end
#Consider replacing the wiki create steps in the before blocks of those 2 specs with using FactoryGirl.