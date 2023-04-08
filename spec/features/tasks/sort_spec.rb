require 'rails_helper'

describe 'User can sort tasks', "
  In order to see tasks in a certain order
  As an authenticated user
  I'd like to be able to sort tasks by different parameters
" do
  describe 'Registred user' do
    it 'can sort tasks by title' do
      user = create(:user)
      create(:task, title: 'Task 2', user: user)
      create(:task, title: 'Task 3', user: user)
      create(:task, title: 'Task 1', user: user)

      sign_in(user)
      visit tasks_path
      within('thead') do
        click_link 'Title'
      end

      task_titles = all('.task-title').map(&:text)
      expect(task_titles).to eq(['Task 1', 'Task 2', 'Task 3'])
    end

    it 'can sort tasks by due date' do
      user = create(:user)
      task3 = create(:task, due_date: Time.zone.today + 3.days, user: user)
      task2 = create(:task, due_date: Time.zone.today + 2.days, user: user)
      task1 = create(:task, due_date: Time.zone.today + 1.day, user: user)

      sign_in(user)
      visit tasks_path
      within('thead') do
        click_link 'Due date'
      end

      task_due_dates = all('.task-due-date').map(&:text)
      expect(task_due_dates).to eq([task1.due_date.to_s, task2.due_date.to_s, task3.due_date.to_s])
    end
  end

  it 'Unregistred user can not see any tasks' do
    visit tasks_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
