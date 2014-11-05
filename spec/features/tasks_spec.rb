require 'rails_helper'

feature "Tasks" do

  scenario "User creates a Task" do

    visit tasks_path
    expect(page).to have_content("Tasks")

    click_on "Create Task"
    expect(page).to have_content("New Task")


    fill_in "Description", with: "Extreme Testing!"
    fill_in "Due date", with: "11/04/2014"
    click_on "Create Task"

    expect(page).to have_content("Extreme Testing!")
    expect(page).to have_content("Task was successfully created.")
    save_and_open_page


  end

  scenario "User wants to see a task" do

    Task.create!(
      description: "Feed the dog" , complete: "false" , due_date: "11/04/2014"
    )

      visit tasks_path
      expect(page).to have_content("Feed the dog")
      click_on "Show"
      expect(page).to have_content("Feed the dog")
      expect(page).to have_no_content("Password")
      save_and_open_page

  end

  scenario "User wants to edit a task" do

    Task.create!(
      description: "Feed the dog" , complete: "false" , due_date: "11/04/2014"
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
      save_and_open_page

  end

  scenario "User wants to delete a Task" do

    Task.create!(
      description: "Feed the dog" , complete: "false" , due_date: "11/04/2014"
    )

    visit tasks_path
    expect(page).to have_content("Feed the dog")
    click_on "Destroy"
    expect(page).to have_no_content("Feed the dog")
    save_and_open_page

  end

end
