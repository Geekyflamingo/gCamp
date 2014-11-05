require 'rails_helper'

feature "Sign Up" do

  scenario "User wants to sign up with valid data" do

    visit root_path
    expect(page).to have_content("gCamp")

    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")

    fill_in "First Name", with: "Mr."
    fill_in "Last Name", with: "Rogers"
    fill_in "Email", with: "bemyneighbor@example.com"
    fill_in "Password", with: "rogers"
    fill_in "Password Confirmation", with: "rogers"
    click_on "Sign up"
    expect(page).to have_content("Mr. Rogers")
    expect(page).to have_content("Sign Out")
    expect(page).to have_no_content("Sign In")

  end


end
