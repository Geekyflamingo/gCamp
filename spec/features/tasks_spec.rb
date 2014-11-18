require 'rails_helper'

feature "Tasks" do
  before do
    Project.create!(
      name: "YAY!")
  end

  scenario "User creates a Task and clicks on show" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Description", with: "Extreme!"
    fill_in "Due date", with: Date.today
    click_on "Create Task"
    expect(page).to have_content("Tasks for YAY!")
    expect(page).to have_content("Task was successfully created.")
    visit projects_path
    click_on "YAY!"
    click_on "1 Task"
    click_on "Show"
    expect(page).to have_content("Extreme!")

  end

  # scenario "User wants to see a task" do
  #   Task.create!(
  #     description: "Feed the dog" , complete: "false" , due_date: Date.today
  #   )
  #
  #   visit projects_path
  #   expect(page).to have_content("Projects")
  #   click_on "YAY!"
  #   expect(page).to have_content("Edit")
  #   save_and_open_page
  #   click_link "1 Task"
  #   click_on "Show"
  #   expect(page).to have_content("Feed the dog")
  #   expect(page).to have_no_content("Task was successfully created.")
  #
  # end

  # scenario "User wants to edit a task" do
  #
  #   Task.create!(
  #     description: "Feed the dog" , complete: "false" , due_date: Date.today
  #   )
  #
  #   visit tasks_path
  #   expect(page).to have_content("Feed the dog")
  #   click_on "Edit"
  #   expect(page).to have_content("Editing task")
  #   expect(page).to have_no_content("Password")
  #   check "Complete"
  #   click_on "Update Task"
  #   expect(page).to have_content("Feed the dog")
  #   click_on "Tasks"
  #   expect(page).to have_no_content("Feed the dog")
  #   click_on "All"
  #   expect(page).to have_content("Feed the dog")
  #
  # end
  #
  # scenario "User wants to delete a Task" do
  #
  #   Task.create!(
  #     description: "Feed the dog" , complete: "false" , due_date: Date.today
  #   )
  #
  #   visit tasks_path
  #   expect(page).to have_content("Feed the dog")
  #   click_on "Destroy"
  #   expect(page).to have_no_content("Feed the dog")
  #
  # end
  #
  # scenario "User wants to create a Task without a description" do
  #
  #   visit tasks_path
  #   expect(page).to have_content("Tasks")
  #   click_on "Create Task"
  #   expect(page).to have_content("New Task")
  #   click_on "Create Task"
  #   expect(page).to have_content("Description can't be blank")
  # end

end
