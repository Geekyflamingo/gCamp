require 'rails_helper'

feature "Sign in" do

  scenario "User wants to sign in with valid data" do

    User.create(
      { first_name: 'AA',
      last_name: 'BB',
      email: 'aa@bb.com',
      password: 'aabb',
      password_confirmation: 'aabb' }
    )

    visit root_path
    expect(page).to have_content("gCamp")
    click_link ("Sign In")
    expect(page).to have_content("Sign into gCamp")

    fill_in "Email", with: "aa@bb.com"
    fill_in "Password", with: "aabb"
    click_button("Sign in")
    expect(page).to have_content("AA")
    expect(page).to have_content("Sign Out")
    expect(page).to have_no_content("Sign In")

  end

  scenario "User wants to sign in with invalid data -email is wrong" do

  User.create(
    { first_name: 'AA',
    last_name: 'BB',
    email: 'aa@bb.com',
    password: 'aabb',
    password_confirmation: 'aabb' }
  )

  visit root_path
  expect(page).to have_content("gCamp")
  click_link ("Sign In")
  expect(page).to have_content("Sign into gCamp")

  fill_in "Email", with: "ab@bb.com"
  fill_in "Password", with: "aabb"
  click_button("Sign in")
  expect(page).to have_content("Username / password combination is invalid")
  expect(page).to have_content("Sign In")
  expect(page).to have_no_content("Sign Out")

  end

  scenario "User wants to sign in with invalid data - password is wrong" do

  User.create(
    { first_name: 'AA',
    last_name: 'BB',
    email: 'aa@bb.com',
    password: 'aabb',
    password_confirmation: 'aabb' }
  )

  visit root_path
  expect(page).to have_content("gCamp")
  click_link ("Sign In")
  expect(page).to have_content("Sign into gCamp")

  fill_in "Email", with: "aa@bb.com"
  fill_in "Password", with: "abbb"
  click_button("Sign in")
  expect(page).to have_content("Username / password combination is invalid")
  expect(page).to have_content("Sign In")
  expect(page).to have_no_content("Sign Out")

  end


end
