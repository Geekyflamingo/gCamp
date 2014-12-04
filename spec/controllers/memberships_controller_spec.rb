require 'rails_helper'

describe MembershipsController do
  before do
    @user = User.create!(
      first_name: "Betty",
      last_name: "Boop",
      password: "boop",
      email: "betty@example.com"
    )

    @project = Project.create!(
      name:"Acme"
    )

  end

  it "does not allow non-logged in users to view" do
    get :index, project_id: @project.id
    expect(response).to redirect_to(signin_path)
  end

  it "does not allow non-members to view" do
    session[:user_id] = @user.id
    patch :index, project_id: @project.id
    expect(response.status).to eq(404)
  end

  it "members can't update membership role" do
    @membership = Membership.create!(
    user: @user,
    project: @project,
    role: 'Member'
    )
    session[:user_id] = @user.id
    patch :update, project_id: @project.id, id: @membership.id
    expect(response.status).to eq(404)
  end

  it "allows owners to update membership role" do
    skip
    @membership = Membership.create!(
    user: @user,
    project: @project,
    role: 'Owner'
    )
    session[:user_id] = @user.id
    patch :update, project_id: @project.id, id: @membership.id
    expect(response.status).to eq(200)
  end



  end
