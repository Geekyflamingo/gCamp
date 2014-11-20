require 'rails_helper'

describe "Membership" do

  it "validates presence of user when creating new membership" do
    user = User.create!(
      first_name: "Betty",
      last_name: "Boop",
      email: "betty@example.com",
      password: "password",
      password_confirmation: "password"
      )
    project = Project.create!(name: "Movie")
    membership = project.memberships.new(
        role: "Owner"
        )
    expect(membership.valid?).to eq(false)
    expect(membership.errors[:user_id].present?).to eq(true)
  end

  it "validates uniqueness of user when creating new membership" do
    user = User.create!(
      first_name: "Betty",
      last_name: "Boop",
      email: "betty@example.com",
      password: "password",
      password_confirmation: "password"
      )
    project = Project.create!(name: "Movie")
    membership = project.memberships.create!(
        role: "Owner",
        user_id: user.id
        )
    second_membership = project.memberships.new(
        role: "Member",
        user_id: user.id
        )
    expect(second_membership.valid?).to eq(false)
    expect(second_membership.errors[:user_id].present?).to eq(true)
  end

end
