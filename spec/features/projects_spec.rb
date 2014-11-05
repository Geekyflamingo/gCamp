require 'rails_helper'

feature "Projects" do

  scenario "User creates a Project" do

    visit projects_path
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")


    fill_in "Name", with: "Build something!"
    click_on "Create Project"

    expect(page).to have_content("Build something!")

  end

  scenario "User wants to see a project" do

    Project.create!(
      name: "Build a boat"
    )

      visit projects_path
      expect(page).to have_content("Build a boat")
      click_on "Build a boat"
      expect(page).to have_content("Build a boat")
      expect(page).to have_content("Edit")
      expect(page).to have_no_content("test")

  end

  scenario "User wants to edit a project" do

    Project.create!(
      name: "End War"
    )

      visit projects_path
      expect(page).to have_content("End War")
      click_on "End War"
      expect(page).to have_content("End War")
      expect(page).to have_no_content("test")
      click_on "Edit"
      expect(page).to have_content("Edit Project")
      fill_in "Name", with: "Build a dog house"
      click_on "Update Project"
      expect(page).to have_no_content("End War")
      expect(page).to have_content("Build a dog house")

  end


end
