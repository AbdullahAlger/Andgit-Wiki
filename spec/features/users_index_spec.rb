require 'rails_helper'

feature '[[index user wikis]]' do

  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
    visit "/wikis"
    @wiki = create(:wiki, user: user)
  end

  scenario "click the 'My Wikis' link to show user's wikis" do
    click_link "My Wikis"
    expect(current_path).to eq("/users")
    expect(page).to have_content(@wiki.title)
  end

  scenario "click the 'My Wikis', but it doesn't show wikis made by other users" do
    other_user = create(:user)
    other_wiki = create(:wiki, user: other_user)
    click_link "My Wikis"
    expect(current_path).to eq("/users")
    expect(page).not_to have_content(other_wiki)
  end

end