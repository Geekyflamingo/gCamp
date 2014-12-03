require 'rails_helper'
require 'spec_helper'

feature "Comments" do

  scenario "User should be able to create a new comment on the tasks show page." do
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
    fill_in "Name", with: "Build a doghouse"
    click_button "Create Project"
    expect(page).to have_content ("Tasks for Build a doghouse")
    expect(page).to have_content("Project was successfully created")
    click_on "Create Task"
    fill_in "Description", with: "Buy Nails"
    click_on "Create Task"
    expect(page).to have_content("Task was successfully created")
    within '.table' do
      click_on "Buy Nails"
    end
    expect(page).to have_content ("Comments")
    fill_in  "comment_description", with: "WOO!"
    click_on "Add Comment"
    expect(page).to have_content("WOO!")
    click_link "Tasks"
    expect(page).to have_content("1")

  end

  scenario "User should not be able to go to task show page and make a new comment when not logged in." do
    project = Project.create!(
      name: "YAY!")

    task = project.tasks.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )

    visit project_tasks_path(project)
    expect(page).to have_content("You must be logged in to access that action")
    expect(page).to have_content("Sign into gCamp")

  end
end
