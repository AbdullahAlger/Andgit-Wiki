require 'rails_helper'

feature '[[create wikis]]' do

  before(:each) do
    user = FactoryGirl.create(:user)
    user.save
    login_as(user, :scope => :user)
  end

  scenario "click the button to make a new wiki" do

    visit "/wikis"
    expect(current_path).to eq("/wikis")

    click_link("Create Wiki")
    expect(page).to have_content("Title" && "Wiki")
  end

  scenario "enter content to make a new wiki" do

    visit "/wikis/new"
    expect(current_path).to eq("/wikis/new")

    fill_in :wiki_title, :with => "New Wiki Title"
    fill_in :wiki_body, :with => "This is some content in the wiki."

    click_button "Save"
    expect(current_path).to eq('/wikis/1')
    expect(page).to have_content "Wiki was saved."
    expect(page).to have_content "New Wiki Title"
    expect(page).to have_content "This is some content in the wiki."
  end

end
