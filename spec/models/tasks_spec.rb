require 'rails_helper'


describe Task do

  it 'validates the presence of a description' do

    task = Task.new
    task.valid?
    expect(task.errors[:description].present?).to eq(true)
    task.description = 'test'
    task.valid?
    expect(task.errors[:description].present?).to eq(false)

  end

  it 'validates that task date is vaild' do

    task = Task.new
    task.valid?
    expect(task.errors[:description].present?).to eq(true)
    task.description = 'test'
    task.valid?
    expect(task.errors[:description].present?).to eq(false)
    task.due_date = Date.today-7
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)
    task.due_date = Date.today+7
    task.valid?
    expect(task.errors[:due_date].present?).to eq(false)

  end

  it 'validates that task date is vaild in edit' do
    task = Task.create!(description: "task", due_date: Date.today+7)
    task.due_date = Date.today-7
    task.valid?
    expect(task.errors[:due_date].present?).to eq(false)
    task.due_date = Date.today+7
    task.valid?
    expect(task.errors[:due_date].present?).to eq(false)

  end

end
