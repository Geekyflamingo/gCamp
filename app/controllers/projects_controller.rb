class ProjectsController < InternalController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :project_id_match, only: [:show, :edit, :update, :destroy]

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
    if owner?.empty?
      render 'public/404', status: :not_found, layout: false
    end
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
    if owner?.empty?
      render 'public/404', status: :not_found, layout: false
    else
      @project.destroy
      redirect_to projects_path, notice: 'Project was successfully deleted.'
    end
 end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
