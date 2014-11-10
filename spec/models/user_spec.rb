require 'rails_helper'

feature "users" do
  scenario "User creates a user" do

  visit users_path
  expect(page).to have_content("Users")

  click_on "Create User"
  expect(page).to have_content("New User")

  click_on "Create User"

  expect(page).to have_content("First name can't be blank")
  end
end
