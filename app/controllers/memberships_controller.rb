class MembershipsController < ApplicationController
before_action do
  @project = Project.find(params[:project_id])
end

before_action :set_membership, only: [:show, :edit, :update, :destroy]

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
      redirect_to project_memberships_path(@project), notice: "Membership Created"
    else
      @memberships = @project.memberships.all
      render :index
    end
  end

  def update
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "Membership Was Updated"
    else
      render :index
    end
  end

  def destroy
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: 'Member was successfully deleted.'
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

end
