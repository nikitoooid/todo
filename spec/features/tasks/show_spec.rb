require 'rails_helper'

describe 'User can view a task', "
  In order to see the details of a task
  As an authenticated user
  I'd like to be able to view a task
" do
  describe 'Registred user' do
    it 'can view his own task' do
      user = create(:user)
      task = create(:task, user: user)

      sign_in(user)
      visit task_path(task)

      expect(page).to have_content(task.title)
    end

    it "can not see other user's task" do
      user = create(:user)
      another_user = create(:user)
      another_task = create(:task, user: another_user)

      sign_in(user)
      visit task_path(another_task)

      expect(page).not_to have_content(another_task.title)
    end
  end

  it "Unregistred user can't see any tasks" do
    user = create(:user)
    task = create(:task, user: user)

    visit task_path(task)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
