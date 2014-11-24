require 'rails_helper'

feature "Membership" do

  before do
    @project = Project.create!(
      name: "YAY!")
    user = User.create!(
      first_name: "Dodger",
      last_name: "Oliver",
      email: "do@example.com",
        password: "pass", password_confirmation: "pass"
      )
  end

  scenario "User creates a Member to a project" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Members"
    expect(page).to have_content("Manage Members")
    select "Dodger Oliver", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("Dodger Oliver was added successfully")
    expect(page).to have_content("Dodger Oliver")
    click_on "YAY!"
    expect(page).to have_content("1 Member")
  end

  scenario "User wants to edit a Member" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Members"
    expect(page).to have_content("Manage Members")
    select "Dodger Oliver", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("Dodger Oliver was added successfully")
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
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Members"
    expect(page).to have_content("Manage Members")
    select "Dodger Oliver", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("Dodger Oliver was added successfully")
    expect(page).to have_content("Dodger Oliver")
    click_on "Dodger Oliver"
    expect(page).to have_content("Email: do@example.com")

  end

  scenario "User wants to delete a Member" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Members"
    expect(page).to have_content("Manage Members")
    select "Dodger Oliver", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("Dodger Oliver was added successfully")
    expect(page).to have_content("Dodger Oliver")
    find('.glyphicon').click
    expect(page).to have_content("Dodger Oliver was deleted successfully")

  end

  scenario "User wants to add a Member without selecting a user" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Members"
    expect(page).to have_content("Manage Members")
    click_on "Add New Member"
    expect(page).to have_content("User can't be blank")

  end

  scenario "User cannot add a Member that is already there" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Members"
    expect(page).to have_content("Manage Members")
    select "Dodger Oliver", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("Dodger Oliver was added successfully")
    within '.table' do
      expect(page).to have_content("Dodger Oliver")
    end
    select "Dodger Oliver", from: "membership_user_id"
    within('.well') do
      select "Member", from: "membership_role"
    end
    click_on "Add"
    expect(page).to have_content("User has already been taken")

  end


end
