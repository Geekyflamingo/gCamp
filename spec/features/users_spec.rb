require 'rails_helper'

feature "Users" do

  before do
    User.create!(
    first_name: "James",
    last_name: "Dean",
    email: "dean@email.com",
    password: "pass",
    password_confirmation: "pass"
    )
    User.create!(
    first_name: "Betty",
    last_name: "Boop",
    email: "betty@email.com",
    password: "boop",
    password_confirmation: "boop"
    )
    visit signin_path
    fill_in "Email", with: "betty@email.com"
    fill_in "Password", with: "boop"
    click_button "Sign in"
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Betty Boop")
  end

  scenario "User edits a user" do

    visit users_path
    expect(page).to have_content("James Dean")
    within'.table tr', text: "James" do
      click_on "Edit"
    end
    fill_in "First Name", with: "Frank"
    fill_in "Last Name", with: "Sinatra"
    fill_in "Email", with: "blueeyes@example.com"
    click_on "Update User"
    expect(page).to have_content("Frank")
    expect(page).to have_no_content("James")

  end

  scenario "User wants to see a user" do

    visit users_path
    expect(page).to have_content("Betty Boop")
    within '.table tr', text: "Betty" do
      click_on "Betty Boop"
    end
    expect(page).to have_content("Betty Boop")
    expect(page).to have_no_content("Password")

  end

  scenario "User wants to click the edit link in the show page" do

    visit users_path
    expect(page).to have_content("Betty Boop")
    within '.table tr', text: "Betty" do
      click_on "Betty Boop"
    end
    expect(page).to have_content("Betty Boop")
    click_on "Edit User"
    expect(page).to have_content("Edit User")

  end

  scenario "User wants to delete a user" do
    visit users_path
    expect(page).to have_content("Betty Boop")
    within '.table tr', text: "Betty" do
      click_on "Betty Boop"
    end
    expect(page).to have_content("Betty Boop")
    click_on "Edit User"
    expect(page).to have_content("Edit User")
    click_on "Delete User"
    expect(page).to have_no_content("Betty Boop")

  end


end
