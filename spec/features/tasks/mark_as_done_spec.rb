require 'rails_helper'

describe 'User can mark a task as done', "
  In order to keep track of completed tasks
  As an authenticated user
  I want to be able to mark a task as done
" do
  it 'User tries to mark task as done', js: true do
    user = create(:user)
    task = create(:task, user: user)

    sign_in(user)
    visit root_path

    within "#task_#{task.id}" do
      find('.checkbox').click
    end
    expect(page).to have_css("#task_#{task.id}.done")
    expect(task.reload.is_done).to be true
  end
end
