class ProjectsController < InternalController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :membership_id_match, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
      Membership.create(project_id: @project.id, user_id: current_user.id, role: "Owner")
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to project_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

  def memberships
    @memberships = Membership.all
  end

  def membership_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    @project = Project.find(params[:id])
     unless project_list.include?(@project.id)
        raise AccessDenied
    end

  end

end
