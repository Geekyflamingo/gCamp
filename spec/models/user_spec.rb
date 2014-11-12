require 'rails_helper'


describe User do

  it 'verifies that user is invaild' do

    user = User.new
    expect(user.valid?).to be(false)
    user.first_name =
    expect(user.valid?).to be(false)
    user.last_name=
    expect(user.valid?).to be(false)
    user.email=
    expect(user.valid?).to be(false)

  end

  it 'verifies that user is vaild' do

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

end
