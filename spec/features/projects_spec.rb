require 'rails_helper'

feature "Projects" do

  scenario "User creates a Project and is an Owner" do
    user = User.create!(
    first_name: "Dodger",
    last_name: "Oliver",
    email: "do@example.com",
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
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")
    fill_in "Name", with: "Build something!"
    click_on "Create Project"
    expect(page).to have_content("Tasks for Build something!")
    within '.breadcrumb' do
      click_on "Build something!"
    end
    expect(page).to have_content("1 Member")
    click_on "1 Member"
    expect(page).to have_content("Manage Members")
    expect(page).to have_content("Dodger Oliver")
    expect(page).to have_content("Owner")

  end


  scenario "User wants to see a project" do

    user = User.create!(
    first_name: "Dodger",
    last_name: "Oliver",
    email: "do@example.com",
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
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")
    fill_in "Name", with: "Build something!"
    click_on "Create Project"
    expect(page).to have_content("Tasks for Build something!")
    within '.breadcrumb' do
      click_on "Projects"
    end
    within '.dropdown' do
      click_on "Build something!"
    end
    expect(page).to have_content("1 Member")
    expect(page).to have_content("Edit")
    expect(page).to have_no_content("test")
  end

  scenario "User wants to edit a project" do

    user = User.create!(
    first_name: "Dodger",
    last_name: "Oliver",
    email: "do@example.com",
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
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")
    fill_in "Name", with: "Build a doghouse"
    click_on "Create Project"
    expect(page).to have_content("Tasks for Build a doghouse")
    within '.breadcrumb' do
      click_on "Build a doghouse"
    end
    expect(page).to have_content("1 Member")
    click_on "Edit"
    expect(page).to have_content("Edit Project")
    fill_in "Name", with: "End War"
    click_on "Update Project"
    expect(page).to have_content("Project was successfully updated.")
  end

  scenario "User wants to delete a Project" do
    user = User.create!(
    first_name: "Dodger",
    last_name: "Oliver",
    email: "do@example.com",
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
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")
    fill_in "Name", with: "Build a doghouse"
    click_on "Create Project"
    expect(page).to have_content("Tasks for Build a doghouse")
    within '.breadcrumb' do
      click_on "Build a doghouse"
    end
    expect(page).to have_content("1 Member")
    click_on "Delete"
    expect(page).to have_content("Project was successfully deleted")
  end

  scenario "User want to create a Project w/o a name" do
    user = User.create!(
    first_name: "Dodger",
    last_name: "Oliver",
    email: "do@example.com",
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
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")

  end

end
