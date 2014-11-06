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

  scenario "User edits a user" do

    User.create!(
      first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
      password: "pass", password_confirmation: "pass"
    )

    visit users_path
    expect(page).to have_content("Mr. T")
    click_on "Edit"
    fill_in "First Name", with: "Frank"
    fill_in "Last Name", with: "Sinatra"
    fill_in "Email", with: "blueeyes@example.com"
    click_on "Update User"

    expect(page).to have_content("Frank")
    expect(page).to have_no_content("Mr. T")

  end

  scenario "User wants to see a user" do

    User.create!(
      first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
      password: "pass", password_confirmation: "pass"
    )

    visit users_path
    expect(page).to have_content("Mr. T")
    click_on "Mr. T"
    expect(page).to have_content("Mr. T")
    expect(page).to have_no_content("Password")


  end

scenario "User wants to click the edit link in the show page" do

  User.create!(
    first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
    password: "pass", password_confirmation: "pass"
  )

  visit users_path
  expect(page).to have_content("Mr. T")
  click_on "Mr. T"
  expect(page).to have_content("Mr. T")
  expect(page).to have_no_content("Password")
  click_on "Edit"
  expect(page).to have_content("Edit User")


end

scenario "User wants to click the back link in the show page" do

  User.create!(
    first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
    password: "pass", password_confirmation: "pass"
  )

  visit users_path
  expect(page).to have_content("Mr. T")
  click_on "Mr. T"
  expect(page).to have_content("Mr. T")
  expect(page).to have_no_content("Password")
  click_on "Back"
  expect(page).to have_content("Users")


end

  scenario "User wants to delete a user" do

    User.create!(
      first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
      password: "pass", password_confirmation: "pass"
    )

    visit users_path
    expect(page).to have_content("Mr. T")
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content("Mr. T")


  end

  
end
