require 'rails_helper'
require 'spec_helper'


feature "the create process" do

  scenario "user is logged in" do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "New Goal"

    expect(page).to have_content("New Goal")
  end

  scenario "user submits new goal" do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "New Goal"
    fill_in "Title", :with => "sleep a lot"
    fill_in "Details", :with => "sleep 13 hours a day"
    click_on "New Goal"

    expect(page).to have_content("sleep a lot")
    expect(page).to have_content("sleep 13 hours a day")
  end

  scenario "only current user can create a goal for themselves" do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    visit new_user_url
    fill_in 'Username', :with => "Mike"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    visit users_url
    click_on "Scott"

    expect(page).to_not have_content("New Goal")
  end
end

feature "The Index/Show process" do
  before :each do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "New Goal"
    fill_in "Title", :with => "sleep a lot"
    fill_in "Details", :with => "sleep 13 hours a day"
    click_on "New Goal"

    visit new_goal_url
    fill_in "Title", :with => "runs a lot"
    fill_in "Details", :with => "run 13 hours a day"
    click_on "New Goal"
  end

  scenario 'Show current users goals' do
    visit goals_url
    expect(page).to have_content("sleep a lot")
    expect(page).to have_content("runs a lot")
  end

  scenario 'Show goal show page from index' do
    visit goals_url
    click_on "sleep a lot"

    expect(page).to have_content("sleep a lot")
    expect(page).to have_content("sleep 13 hours a day")
  end

  scenario 'Complete goal button' do
    visit goal_url(Goal.first)
    click_on 'Complete'
    expect(page).to have_content("Completed")
    expect(page).to have_button("Did not complete")
  end

  scenario 'Button back to user show page' do
    visit goal_url(Goal.first)
    click_on 'Back to User'
    expect(page).to have_content("runs a lot")
    expect(page).to have_content("sleep a lot")
  end

  scenario 'Flash success message when updating goal' do
    visit goal_url(Goal.last)

    click_on "Complete"
    expect(page).to have_content("Goal updated")
  end
end

feature "show other user's public goal" do
  before :each do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "New Goal"
    fill_in "Title", :with => "run a lot"
    fill_in "Details", :with => "runs 13 hours a day"
    check "Visibility"
    click_on "New Goal"

    visit new_user_url
    fill_in 'Username', :with => "Mike"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "New Goal"
    fill_in "Title", :with => "sleep a lot"
    fill_in "Details", :with => "sleep 13 hours a day"
    click_on "New Goal"
  end

  scenario "visits all user page (index)" do
    visit users_url
    expect(page).to have_content("Scott")
    expect(page).to have_content("Mike")
  end

  scenario 'Show users goal in users show page' do
    visit user_url(User.last)
    expect(page).to have_content("sleep a lot")
  end

  scenario 'Should not show other user private goals' do
    visit user_url(User.first)
    expect(page).to_not have_content("run a lot")
  end
end

feature "delete current user's goals" do
  before :each do
    visit new_user_url
    fill_in 'Username', :with => "Scott"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    click_on "New Goal"
    fill_in "Title", :with => "run a lot"
    fill_in "Details", :with => "runs 13 hours a day"
    check "Visibility"
    click_on "New Goal"
  end

  scenario 'Allow current user to delete their goals' do
    visit goal_url(Goal.last)
    click_button "Delete Goal"

    expect(page).to_not have_content("run a lot")
  end

  scenario "Don't allow user to delete other users goals" do
    visit new_user_url
    fill_in 'Username', :with => "Mike"
    fill_in 'Password', :with => "good_password"
    click_on "Create User"

    visit goal_url(Goal.last)
    expect(page).to_not have_content("Delete Goal")
  end
end
