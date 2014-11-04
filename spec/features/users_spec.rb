require 'rails_helper'

feature "Users" do

  scenario "User creates a user" do

    visit users_path
    expect(page).to have_content("Users")

    click_on "Create User"
    expect(page).to have_content("New User")


    fill_in "First Name", with: "Extreme"
    fill_in "Last Name", with: "smith"
    fill_in "Email", with: "smith@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password Confirmation", with: "pass"
    click_on "Create User"

    expect(page).to have_content("Extreme")

  end

end
