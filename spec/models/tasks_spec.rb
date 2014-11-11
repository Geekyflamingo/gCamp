require 'rails_helper'


describe Task do

  it 'verifies that task due date is invaild' do

    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'test'
    expect(task.valid?).to be(true)
    task.due_date = Date.today-7
    expect(task.valid?).to be(false)

  end

  it 'verifies that task date is vaild' do

    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'test'
    expect(task.valid?).to be(true)
    task.due_date = Date.today+7
    expect(task.valid?).to be(true)

  end

  it 'verifies that task date is invaild in edit' do

    task = Task.new
    expect(task.valid?).to be(false)
    task.description =
    expect(task.valid?).to be(false)
    task.due_date = Date.today+7
    expect(task.valid?).to be(true)


  end

end
