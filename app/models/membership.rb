class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  validates :user_id, presence: :true, uniqueness: { scope: :project_id }

  before_destroy :cannot_delete_last_owner
  before_update :cannot_update_last_owner

  def cannot_delete_last_owner
    if owners.count == 1 && self.role == 'Owner'
      return false
    end
  end

  def cannot_update_last_owner
    if owners.count > 1
      return true
    elsif owners.count == 1 && role == 'Member'
      return false
      end
  end

  def owners
    project.memberships.where(role: 'Owner')
  end

  def members
    project.memberships.where(role: 'Member')
  end

  private
end
