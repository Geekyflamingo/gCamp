class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user

    User.find_by(id: session[:user_id])
  end

  def admin?
    current_user.admin == true
  end

  def owner?
    @project.memberships.where(role: 'Owner', user_id: current_user) || admin?
  end

  def member?
    @project.memberships.where(role: 'Member', user_id: current_user) || admin?
  end

  def authorize_user
    @user = User.find(params[:id])
    return true if admin?
    unless current_user == @user
      raise AccessDenied
    end
  end

  def store_url
    if request.get?
      session[:first_url] = request.url
    end
  end

  def redirect_back_after_authentication
    redirect_to(session[:first_url] || projects_path)
    session.delete(:first_url)
  end


  helper_method :authorize_user
  helper_method :current_user
  helper_method :owner?
  helper_method :member?
  helper_method :admin?


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
    unless admin? || project_list.include?(@project.id)
      raise AccessDenied
    end
  end

  def tasks_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    unless admin? || project_list.include?(@project.id)
      raise AccessDenied
    end
  end

  def members_on_same_project_can_see_emails
    current_user_projects = current_user.memberships.where(project_id: Project.all).pluck(:project_id)
  end


end
