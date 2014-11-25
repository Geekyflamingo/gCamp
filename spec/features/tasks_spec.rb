require 'rails_helper'

feature "Tasks" do

  before do
    @project = Project.create!(
      name: "YAY!")
  end

  scenario "User creates a Task and clicks on task to go to show page" do
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
    click_on("Projects",match: :first)
    click_on "YAY!"
    click_on "1 Task"
    click_on "Extreme!"
    expect(page).to have_content("Comments")

  end

  scenario "User wants to edit a task and update it with a date in the past" do

    @project.tasks.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )

    visit projects_path
    expect(page).to have_content("YAY!")
    click_on "1"
    expect(page).to have_content("Tasks for YAY!")
    click_on "Edit"
    expect(page).to have_content("Feed the dog")
    fill_in "Due date", with: Date.today-7
    click_on "Update Task"
    expect(page).to have_no_content("Task was sucessfully updated.")

  end

  scenario "User wants to delete a Task" do

    @project.tasks.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )

    visit projects_path
    expect(page).to have_content("YAY!")
    click_on "1"
    expect(page).to have_content("Tasks for YAY!")
    find('.glyphicon').click
    expect(page).to have_no_content("Feed the dog")

  end

  scenario "User wants to create a Task without a description" do

    visit projects_path
    expect(page).to have_content("Projects")
    click_on "YAY!"
    expect(page).to have_content("Edit")
    click_on "0 Tasks"
    expect(page).to have_content("Tasks for YAY!")
    click_on "Create Task"
    expect(page).to have_content("New Task")
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end
end
