# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'


feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("New User")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'Username', :with => "Scott"
      fill_in 'Password', :with => "good_password"
      click_on "Create User"
      expect(page).to have_content("Scott")
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    visit new_session_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Sign In"

    expect(page).to have_content("Scott")
  end
end

feature "logging out" do
  scenario "begins with a logged out state" do

    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "Logout"

    expect(page).to have_content("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do

    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "Logout"

    expect(page).to_not have_content("Scott")
  end

end
