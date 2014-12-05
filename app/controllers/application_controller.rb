class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def owner?
    @project.memberships.where(role: 'Owner', user_id: current_user)
  end

  def member?
    @project.memberships.where(role: 'Member', user_id: current_user)
  end

  def authorize_user
    @user = User.find(params[:id])
    unless current_user == @user
      raise AccessDenied
    end
  end
  helper_method :authorize_user
  helper_method :current_user
  helper_method :owner?
  helper_method :member?

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  def render_404
    render 'public/404', status: :not_found, layout: false
  end

  private

  def memberships
    @memberships = Membership.all
  end

  def project_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    @project = Project.find(params[:id])
    unless project_list.include?(@project.id)
      raise AccessDenied
    end
  end

  def tasks_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    unless project_list.include?(@project.id)
      raise AccessDenied
    end
  end

  
end
