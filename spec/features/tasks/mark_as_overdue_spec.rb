require 'rails_helper'

describe 'User can see if a task is overdue', "
  In order to keep track of task deadlines
  As an authenticated user
  I'd like to see if a task is overdue
" do
  it 'Authenticated user can see if a task is overdue' do
    user = create(:user)
    task = create(:task, user: user)
    overdue_task = create(:task, due_date: Date.yesterday, user: user)

    sign_in(user)
    visit tasks_path

    expect(page).to have_selector("#task_#{overdue_task.id}.overdue")
    expect(page).to have_selector("#task_#{task.id}")
    expect(page).not_to have_selector("#task_#{task.id}.overdue")
  end

  it 'Unauthenticated user can not see any tasks' do
    user = create(:user)
    task = create(:task, user: user)

    visit tasks_path

    expect(page).not_to have_selector("#task_#{task.id}")
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
