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
      render :new
    end
  end

  def edit
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path, notice: "Member was Updated"
    else
      render :edit
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

end
