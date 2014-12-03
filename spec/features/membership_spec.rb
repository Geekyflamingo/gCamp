require 'rails_helper'

feature "Membership" do

  before do
    user = User.create!(
      first_name: "Dodger",
      last_name: "Oliver",
      email: "do@example.com",
        password: "pass", password_confirmation: "pass"
      )

    user2 = User.create!(
      first_name: "James",
      last_name: "Dean",
      email: "dean@example.com",
      password: "pass", password_confirmation: "pass"
    )
      visit root_path
      expect(page).to have_content("gCamp")
      click_link ("Sign In")
      expect(page).to have_content("Sign into gCamp")
      fill_in "Email", with: "do@example.com"
      fill_in "Password", with: "pass"
      click_button("Sign in")
      expect(page).to have_content("Dodger Oliver")
      expect(page).to have_content("Sign Out")
      expect(page).to have_no_content("Sign In")

      click_on "Create Project"
      fill_in "Name", with: "YAY!"
      click_button "Create Project"
      expect(page).to have_content("YAY!")
      expect(page).to have_content("Project was successfully created.")
    end

  scenario "User creates a Member to a project" do

    visit projects_path
    expect(page).to have_content("Projects")
    within '.table' do
    click_link "YAY!"
    end
    expect(page).to have_content("Edit")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    expect(page).to have_content("Dodger Oliver")
    within '.well' do
      select "James Dean", from: "membership_user_id"
      select "Member", from: "membership_role"
    end
    click_on "Add New Member"
    expect(page).to have_content("James Dean was added successfully")
    within '.breadcrumb' do
      click_link "YAY!"
    end
    expect(page).to have_content("2 Members")
  end

  scenario "User wants to edit a Member" do
    visit projects_path
    expect(page).to have_content("Projects")
    within '.dropdown' do
      click_link "YAY!"
    end
    expect(page).to have_content("Edit")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    expect(page).to have_content("Dodger Oliver")
    within '.table' do
      select "Member", from: "membership_role"
    end
    click_on "Update"
    expect(page).to have_content("Dodger Oliver was updated successfully")
    expect(page).to have_content("Member")
  end

  scenario "User wants to see a member's show page" do
    visit projects_path
    expect(page).to have_content("Projects")
    within '.dropdown' do
      click_link "YAY!"
    end
    expect(page).to have_content("Edit")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    expect(page).to have_content("Dodger Oliver")
    within '.table' do
      click_on "Dodger Oliver"
    end
    expect(page).to have_content("Email: do@example.com")

  end

  scenario "User wants to delete a Member" do
    visit projects_path
    expect(page).to have_content("Projects")
    within '.dropdown' do
      click_link "YAY!"
    end
    expect(page).to have_content("Edit")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    within '.well' do
      select "James Dean", from: "membership_user_id"
      select "Member", from: "membership_role"
    end
    click_on "Add New Member"
    expect(page).to have_content("James Dean was added successfully")
    expect(page).to have_content("James Dean")
    within '.table tr', text: 'James' do
      find('.glyphicon').click
    end
    expect(page).to have_content("James Dean was deleted successfully")

  end

  scenario "User wants to add a Member without selecting a user" do
    visit projects_path
    expect(page).to have_content("Projects")
    within '.dropdown' do
      click_link "YAY!"
    end
    expect(page).to have_content("Edit")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    click_on "Add New Member"
    expect(page).to have_content("User can't be blank")

  end

  scenario "User cannot add a Member that is already there" do
    visit projects_path
    expect(page).to have_content("Projects")
    within '.dropdown' do
      click_link "YAY!"
    end
    expect(page).to have_content("Edit")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    within '.well' do
      select "Dodger Oliver", from: "membership_user_id"
      select "Owner", from: "membership_role"
    end
    click_on "Add New Member"
    expect(page).to have_content("User has already been taken")

  end


end
