class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :set_task, only: [:show, :edit, :create_comment, :update, :destroy]

  def index

    @tasks = @project.tasks.where(complete: false).page(params[:page]).per(5)
    @ref = "incomplete"

    if params[:type] =="all"
      @tasks = @project.tasks.page(params[:page]).per(5)
      @ref = "all"
    end

  end


  def show
    @comment = @task.comments.new
    @comments = @task.comments.all
  end


  def new
    @task = @project.tasks.new
  end


  def edit
  end


  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def create_comment
    comment_params = params.require(:comment).permit(
        :user_id,
        :task_id,
        :description
      )
    if current_user
      @comment = @task.comments.new(params.require(:comment).merge({:user_id => current_user.id}).permit(:description, :user_id, :task_id))
      @comment.save
      redirect_to project_task_path
    else
      @comment = @task.comments.new
      @comments = @task.comments.all
      render :show
    end
  end

  def update
    @task.update(task_params)
    if @task.save
      redirect_to project_tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :complete, :due_date)
    end
end
