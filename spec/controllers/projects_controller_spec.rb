require 'rails_helper'

describe ProjectsController do
  before do
    password = 'password'
    @user = create_user(password: password)

    @project = Project.create!(
    name: "Movie"
    )

    @member = create_user(
    first_name: "James",
    last_name: "Dean",
    email: "james_dean@example.com",
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

    @admin_project = create_project

    @owner_membership = create_membership(@project, @owner, "Owner")
    @admin_membership = create_membership(@admin_project, @admin)
    @member_membership = create_membership(@project, @member, "Member")

  end

  describe "#index" do
    it "does not allow visitors" do
      get :index

      expect(response).to redirect_to(signin_path)
    end

    it "does allow members to view" do
      session[:user_id] = @member.id

      get :index

      expect(response.status).to eq(200)
    end

    it "does allow owners to view" do
      session[:user_id] = @owner.id

      get :index

      expect(response.status).to eq(200)
    end

    it "does allow admins to view" do
      session[:user_id] = @admin.id

      get :index

      expect(response.status).to eq(200)
    end

    it "does allow logged-in users to view" do
      session[:user_id] = @user.id

      get :index

      expect(response.status).to eq(200)
    end
  end

  describe "#new" do
    it "does not allow visitors" do
      get :new

      expect(response).to redirect_to(signin_path)
    end

    it "does allow members to view" do
      session[:user_id] = @member.id

      get :new

      expect(response.status).to eq(200)
    end

    it "does allow owners to view" do
      session[:user_id] = @owner.id

      get :new

      expect(response.status).to eq(200)
    end

    it "does allow admins to view" do
      session[:user_id] = @admin.id

      get :new

      expect(response.status).to eq(200)
    end

    it "does allow logged-in users to view" do
      session[:user_id] = @user.id

      get :new

      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    it "does not allow visitors" do
      @test_project = Project.create!(
      name: "Start filming!"
      )

      post :create, project: {name: "Start filming!"}

      expect(response).to redirect_to(signin_path)
    end

    it "does allow members" do
      session[:user_id] = @member.id

      @test_project = Project.create!(
      name: "Start filming!"
      )

      post :create, project: {name: "Start filming!"}

      expect(response.status).to eq(302)
    end

    it "does allow owners" do
      session[:user_id] = @owner.id

      @test_project = Project.create!(
      name: "Start filming!"
      )

      post :create, project: {name: "Start filming!"}

      expect(response.status).to eq(302)
    end

    it "does allow admins" do
      session[:user_id] = @admin.id

      @test_project = Project.create!(
      name: "Another project?"
      )

      post :create, project: {name: "Another project?"}

      expect(response.status).to eq(302)
    end

    it "does allow logged-in users" do
      session[:user_id] = @user.id

      @test_project = Project.create!(
      name: "Another project?"
      )

      post :create, project: {name: "Another project?"}

      expect(response.status).to eq(302)
    end
  end

  describe "#edit" do
    it "does not allow non-members" do
      session[:user_id] = @user.id

      get :edit, id: @project.id

      expect(response.status).to eq(404)
    end

    it "does not allow members" do
      @membership = create_membership(@project, @user, "Member")

      session[:user_id] = @user.id

      get :edit, id: @project.id

      expect(response.status).to eq(404)
    end

    it "does allow owners" do
      @owner = create_membership(@project, @user, "Owner")
      session[:user_id] = @user.id

      get :edit, id: @project.id

      expect(response.status).to eq(200)
    end

    it "does allow admins" do
      session[:user_id] = @admin.id

      get :edit, id: @project.id

      expect(response.status).to eq(200)
    end

  end

  describe "#update" do
    it "does not allow non-members" do
      session[:user_id] = @user.id

      patch :update, id: @project.id, project: {name: 'blahblah'}

      expect(response.status).to eq(404)
    end

    it "does not allow members" do
      @membership = create_membership(@project, @user, "Member")

      session[:user_id] = @user.id

      patch :update, id: @project.id, project: {name: 'blahblah'}

      expect(Project.last.name).to eq('Movie')
    end

    it "does allow owners" do
      @owner = create_membership(@project, @user, "Owner")
      session[:user_id] = @user.id

      patch :update, id: @project.id, project: {name: 'blahblah'}

      expect(response.status).to eq(302)
    end

    it "does allow admins" do
      session[:user_id] = @admin.id

      patch :update, id: @project.id, project: {name: 'blahblah'}

      expect(response.status).to eq(302)
    end

  end


  describe "#destroy" do

    it "does not allow non-members" do
      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: @project.id

      expect(response.status).to eq(404)
      expect(count).to eq(Project.count)
    end

    it "does not allow project members" do
      @membership = create_membership(@project, @user, "Member")

      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: @project.id

      expect(response.status).to eq(404)
      expect(count).to eq(Project.count)
    end

    it "allows admins to delete" do
      session[:user_id] = @admin.id
      count = Project.count

      delete :destroy, id: @project.id

      expect(Project.count).to eq(count - 1)
      expect(response).to redirect_to(projects_path)
    end

    it "allows owners to delete" do
      @membership = create_membership(@project, @user, "Owner")
      @membership3 = create_membership(@project, @admin, "Owner")

      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: @project.id

      expect(Project.count).to eq(count - 1)
      expect(response).to redirect_to(projects_path)
    end

  end
end
