require 'rails_helper'

feature '[[index user wikis]]' do

  before(:each) do
    user = create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("Log in")
    expect(page).to have_content("Signed in successfully")
    expect(current_path).to eq("/wikis")
    click_link "Create wiki"
    expect(current_path).to eq("/wikis/new")
    fill_in :wiki_title, :with => "New Wiki Title"
    fill_in :wiki_body, :with => "This is some content in the wiki."
    click_button "Save"
    expect(current_path).to eq('/wikis/new-wiki-title')
    expect(page).to have_content "Wiki was saved."
    expect(page).to have_content "New Wiki Title"
    expect(page).to have_content "This is some content in the wiki."
  end

  scenario "click the 'My Wikis' link to show user's wikis" do
    click_link "My Wikis"
    expect(current_path).to eq("/users")
    expect(page).to have_content("New Wiki Title")
  end

end