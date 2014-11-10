require 'rails_helper'


describe Task do

  it 'verifies that task due date is invaild' do

    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'test'
    expect(task.valid?).to be(false)
    task.due_date = '11/4/2014'
    expect(task.valid?).to be(false)
    task.due_date = '11/11/3001'
    expect(task.valid?).to be (true)

  end
end
