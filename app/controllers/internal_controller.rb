class InternalController < ApplicationController
  before_action :ensure_logged_in_user
  before_action :projects
  before_action :admin?

  private
  def ensure_logged_in_user
    unless current_user
      store_url
      redirect_to signin_path, notice: "You must be logged in to access that action"
    end

    def projects
      @projects = Project.all
    end

  end


end
