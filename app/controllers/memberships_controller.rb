class MembershipsController < InternalController
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :tasks_id_match
  before_action :not_owner_render_404, only: [:new, :create, :update]

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def new
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was added successfully."
    else
      @memberships = @project.memberships.all
      render :index
    end
  end

  def update
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was updated successfully."
    else
      render :index
    end
  end

  def destroy
    if @membership.user.id == current_user.id || !owner?.empty?
      @membership.destroy
      redirect_to projects_path, notice: "#{@membership.user.full_name} was deleted successfully."
  end
  end
  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(
    :user_id,
    :project_id,
    :role,
    :first_name,
    :last_name,
    )
  end

  def current_user_has_membership
    @membership.user.id == current_user.id || !owner?.empty?
  end

  def not_owner_render_404
    if owner?.empty?
      raise AccessDenied
    end
  end

end
