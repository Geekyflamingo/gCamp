require 'rails_helper'

describe ProjectsController do
  describe "#index" do
    it "does not allow non-logged in users to view" do
      get :index
      expect(response).to redirect_to(signin_path)
    end
  end
  describe "#edit" do
    before do
      @user = User.create!(
        first_name: "Betty",
        last_name: "Boop",
        password: "boop",
        email: "betty@example.com"
      )
      @project = Project.create!(
      name: "Movie"
      )
    end

    it "does not allow non-members" do
      session[:user_id] = @user.id
      get :edit, id: @project.id
      expect(response.status).to eq(404)
    end

    it "does not allow members" do
      Membership.create!(
      user: @user,
      project: @project,
      role: 'Member'
      )
      session[:user_id] = @user.id
      get :edit, id: @project.id
      expect(response.status).to eq(404)
    end
    it "allows owners" do
      Membership.create!(
      user: @user,
      project: @project,
      role: 'Owner'
      )
      session[:user_id] = @user.id
      get :edit, id: @project.id
      expect(response.status).to eq(200)
    end
    it "allows admins" do
      skip
      Membership.create!(
      user: @user,
      project: @project,
      role: 'Owner'
      )
      session[:user_id] = @user.id
      get :edit, id: @project.id
      expect(response.status).to eq(200)
    end

  end

  describe "#destroy" do
  before do
    @user = User.create!(
      first_name: "Joe",
      last_name: "Example",
      password: "pass",
      email: "joe@example.com"
    )

    @project = Project.create!(
      name: "acme"
    )
  end

  it "does not allow non-members" do
    skip
    session[:user_id] = @user.id
    count = Project.count
    delete :destroy, id: @project.id
    expect(response.status).to eq(404)
    expect(count).to eq(Project.count)

  end

  it "does not allow project members" do
    skip
    Membership.create!(
      user: @user,
      project: @project,
      role: 'Member'
    )
    session[:user_id] = @user.id
    count = Project.count
    delete :destroy, id: @project.id
    expect(response.status).to eq(404)
    expect(count).to eq(Project.count)
  end

  it "allows project Owners" do
    skip
    Membership.create!(
    user: @user,
    project: @project,
    role: 'Owner'
    )
    session[:user_id] = @user.id
    count = Project.count
    delete :destroy, id: @project.id
    expect(response).to redirect_to(projects_path)
    expect(count).to eq(Project.count -1)
  end

  it "allows admin" do
    skip
    Membership.create!(
    user: @user,
    project: @project,
    role: 'Owner'
    )
    session[:user_id] = @user.id
    count = Project.count
    delete :destroy, id: @project.id
    expect(response).to redirect_to(projects_path)
    expect(count).to eq(Project.count -1)
  end

  end
end
