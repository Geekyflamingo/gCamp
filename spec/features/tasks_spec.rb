require 'rails_helper'

feature "Tasks" do

  scenario "User creates a Task" do

    visit tasks_path
    expect(page).to have_content("Tasks")

    click_on "Create Task"
    expect(page).to have_content("New Task")


    fill_in "Description", with: "Extreme Testing!"
    fill_in "Due date", with: Date.today
    click_on "Create Task"

    expect(page).to have_content("Extreme Testing!")
    expect(page).to have_content("Task was successfully created.")



  end

  scenario "User wants to see a task" do

    Task.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )

      visit tasks_path
      expect(page).to have_content("Feed the dog")
      click_on "Show"
      expect(page).to have_content("Feed the dog")
      expect(page).to have_no_content("Password")


  end

  scenario "User wants to edit a task" do

    Task.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )

      visit tasks_path
      expect(page).to have_content("Feed the dog")
      click_on "Edit"
      expect(page).to have_content("Editing task")
      expect(page).to have_no_content("Password")
      check "Complete"
      click_on "Update Task"
      expect(page).to have_content("Feed the dog")

      click_on "Tasks"
      expect(page).to have_no_content("Feed the dog")

      click_on "All"
      expect(page).to have_content("Feed the dog")


  end

  scenario "User wants to delete a Task" do

    Task.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )

    visit tasks_path
    expect(page).to have_content("Feed the dog")
    click_on "Destroy"
    expect(page).to have_no_content("Feed the dog")


  end

  scenario "User wants to create a Task without a description" do

    visit tasks_path
    expect(page).to have_content("Tasks")

    click_on "Create Task"
    expect(page).to have_content("New Task")

    click_on "Create Task"

    expect(page).to have_content("Description can't be blank")
  end


end
