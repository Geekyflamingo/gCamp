require 'rails_helper'


describe User do

  it 'validates that user is invaild' do

    user = User.new
    expect(user.valid?).to be(false)
    user.first_name =
    expect(user.valid?).to be(false)
    user.last_name=
    expect(user.valid?).to be(false)
    user.email=
    expect(user.valid?).to be(false)

  end

  it 'validates that user is vaild' do

    user = User.new
    expect(user.valid?).to be(false)
    user.first_name = 'Bob'
    expect(user.valid?).to be(false)
    user.last_name='Smith'
    expect(user.valid?).to be(false)
    user.email='smith@example.com'
    expect(user.valid?).to be(false)
    user.password='pass'
    expect(user.valid?).to be(true)

  end

  it 'validates that user email is unique regardless of case' do

    User.create!(first_name: "roger", last_name: "smith", email: "roger@example.com", password: "pass")

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
