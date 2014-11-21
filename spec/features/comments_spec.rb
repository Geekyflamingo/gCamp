require 'rails_helper'
require 'spec_helper'

feature "Comments" do

  scenario "User should be able to create a new comment on the tasks show page." do
    project = Project.create!(
      name: "YAY!")

    task = project.tasks.create!(
      description: "Feed the dog" , complete: "false" , due_date: Date.today
    )
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

    visit project_tasks_path(project)
    click_on "Feed the dog"
    fill_in  "comment_description", with: "My comment"
    click_on "Add Comment"
    expect(page).to have_content("My comment")


  end
end
