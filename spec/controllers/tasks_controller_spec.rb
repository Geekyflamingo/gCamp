require 'rails_helper'

describe TasksController do

  describe "#index" do
    before do
      @project = Project.create!(
        name:"Acme"
      )
    end

    it "does not allow non-logged in users to view" do
      get :index, project_id: @project.id
      expect(response).to redirect_to(signin_path)
    end
  end

end
