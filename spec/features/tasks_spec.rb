require 'rails_helper'

feature "Tasks" do

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

  scenario "User creates a Task and clicks on task to go to show page" do

    expect(page).to have_content("Tasks for YAY!")
    click_on "Create Task"
    fill_in "Description", with: "Extreme!"
    fill_in "Due date", with: Date.today
    click_on "Create Task"
    expect(page).to have_content("Tasks for YAY!")
    expect(page).to have_content("Task was successfully created.")
    within '.table' do
      click_on "Extreme!"
    end
    expect(page).to have_content("Comments")
    within '.breadcrumb' do
      click_on "YAY!"
    end
    expect(page).to have_content("1 Task")
    expect(page).to have_content("1 Member")
  end

  scenario "User wants to edit a task and update it with a date in the past" do

    expect(page).to have_content("Tasks for YAY!")
    click_on "Create Task"
    fill_in "Description", with: "Extreme!"
    fill_in "Due date", with: Date.today
    click_on "Create Task"
    expect(page).to have_content("Tasks for YAY!")
    expect(page).to have_content("Task was successfully created.")
    within '.table' do
      click_on "Edit"
    end
    expect(page).to have_content("Editing task")
    fill_in "Due date", with: Date.today-7
    click_on "Update Task"
    expect(page).to have_no_content("Task was sucessfully updated.")

  end

  scenario "User wants to delete a Task" do
    expect(page).to have_content("Tasks for YAY!")
    click_on "Create Task"
    fill_in "Description", with: "Extreme!"
    fill_in "Due date", with: Date.today
    click_on "Create Task"
    expect(page).to have_content("Tasks for YAY!")
    expect(page).to have_content("Task was successfully created.")
    within '.table' do
      find('.glyphicon').click
    end
    expect(page).to have_no_content("Extreme!")
    expect(page).to have_content("Task was successfully destroyed")

  end

  scenario "User wants to create a Task without a description" do
    expect(page).to have_content("Tasks for YAY!")
    click_on "Create Task"
    expect(page).to have_content("New Task")
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end
end
