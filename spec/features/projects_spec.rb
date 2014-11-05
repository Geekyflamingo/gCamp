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

  scenario "User wants to see a task" do

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

end
