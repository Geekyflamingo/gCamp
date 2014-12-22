require 'rails_helper'

describe MembershipsController do

  before do
    password = 'password'

    @user = User.create!(
    first_name: "Dodger",
    last_name: "Oliver",
    email: "do@example.com",
    password: "pass",
    password_confirmation: "pass"
    )

    @project = Project.create!(
    name: "Movie"
    )

    @member = create_user(
    first_name: "James",
    last_name: "Dean",
    email: "dean@example.com",
    password: password,
    )

    @owner = create_user(
    first_name: "Mr.",
    last_name: "T",
    email: "pitythefool@example.com",
    password: password,
    )

    @admin = create_user(
    first_name: "Betty",
    last_name: "Boop",
    email: "boop@email.com",
    password: password,
    admin: true
    )

    @rogers = User.create(
    first_name: "Mr.",
    last_name: "Rogers",
    email: "mr.rogers@example.com",
    password: "pass",
    password_confirmation: "pass"
    )

    @owner_membership = create_membership(@project, @owner, "Owner")
    @member_membership = create_membership(@project, @member, "Member")
  end

  describe "#index" do
    it "doesn't allow non-logged in users to view" do
      get :index, project_id: @project.id

      expect(response).to redirect_to(signin_path)
    end

    it "doesn't allow non-members in users to view" do
      session[:user_id] = @user.id

      get :index, project_id: @project.id

      expect(response.status).to eq(404)
    end

    it "does allow members to view" do
      session[:user_id] = @member.id

      get :index, project_id: @project.id

      expect(response.status).to eq(200)
    end

    it "does allow owners to view" do
      session[:user_id] = @owner.id

      get :index, project_id: @project.id

      expect(response.status).to eq(200)

    end

    it "does allow admins to view" do
      session[:user_id] = @admin.id

      get :index, project_id: @project.id

      expect(response.status).to eq(200)

    end
  end

  describe "#update" do
    it "doesn't allow members to update membership role" do
      @membership = Membership.create!(
      user: @user,
      project: @project,
      role: 'Member'
      )

      session[:user_id] = @user.id

      patch :update, project_id: @project.id, id: @membership.id, membership: {role: 'Member'}

      expect(response.status).to eq(404)
    end

    it "allows owners to update membership role" do

      rogers_membership = Membership.create(
      user: @rogers,
      project: @project,
      role: 'Member'
      )

      @membership = Membership.create!(
      user: @user,
      project: @project,
      role: 'Owner'
      )

      session[:user_id] = @user.id

      patch :update, project_id: @project.id, id: rogers_membership.id, membership:{role: 'Owner'}

      expect(response.status).to eq(302)
    end

    it "allows admins to update membership role" do

      rogers_membership = Membership.create(
      user: @rogers,
      project: @project,
      role: 'Member'
      )

      @membership = Membership.create!(
      user: @user,
      project: @project,
      role: 'Owner'
      )

      session[:user_id] = @admin.id

      patch :update, project_id: @project.id, id: rogers_membership.id, membership:{role: 'Owner'}

      expect(response.status).to eq(302)
    end
  end

end
