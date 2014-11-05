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

end
