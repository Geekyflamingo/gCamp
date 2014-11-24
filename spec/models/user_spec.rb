require 'rails_helper'


describe User do

  it 'validates that user has unique email' do
    User.create!(
      first_name: "James",
      last_name: "Dean",
      email: "dean@email.com",
      password: "pass",
      password_confirmation: "pass"
      )
    user = User.new(
      first_name: "Jimmy",
      last_name: "Dean",
      email: "dean@email.com",
      password: "pass",
      password_confirmation: "pass"
      )
    expect(user.valid?).to be(false)
    expect(user.errors[:email].present?).to eq(true)
  end

  it 'validates that user email is unique regardless of case' do

    User.create!(
    first_name: "roger",
    last_name: "smith",
    email: "roger@example.com",
    password: "pass")

    User.new(email: "roger@example.com")

    user = User.new

    user.valid?
    expect(user.errors[:email].present?).to eq(true)
    user.email = "Roger@example.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(true)
    user.email = "aa@example.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(false)
  end

end
