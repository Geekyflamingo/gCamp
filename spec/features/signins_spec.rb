require 'rails_helper'

  feature "Sign in" do

  scenario "User wants to sign in with valid data" do
    User.create!(
      first_name: "Bob" , last_name: "Smith" , email: "mrt@example.com",
      password: "pass" , password_confirmation: "pass"
    )

      visit root_path
      expect(page).to have_content("gCamp")
      click_on "Sign In"
      expect(page).to have_content("Sign into gCamp")
      fill_in "Email", with: "mrt@example.com"
      fill_in "Password", with: "pass"
      within(".well") do
      click_on("Sign in")
      end
      expect(page).to have_content("Bob Smith")
      expect(page).to have_content("Sign Out")
      expect(page).to have_content("Sign In")

  end

 end
