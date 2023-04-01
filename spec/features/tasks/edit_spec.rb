require 'rails_helper'

describe 'User can edit his task', "
  In order to correct mistakes in my task
  As an authenticated user
  I'd like to be able to edit my task
" do
  describe 'Registred user' do
    it 'can edit his task' do
      user = create(:user)
      task = create(:task, user: user)

      sign_in(user)
      visit edit_task_path(task)

      fill_in 'Title', with: 'New Title'
      click_button 'Update Task'

      expect(page).to have_content('New Title')
    end

    it 'can not edit other user task' do
      user = create(:user)
      another_user = create(:user)
      another_user_task = create(:task, user: another_user)

      sign_in(user)
      visit edit_task_path(another_user_task)

      expect(page).to have_content 'You are not authorized to perform this action.'
    end
  end

  it 'Unregistred user can not edit any tasks' do
    user = create(:user)
    task = create(:task, user: user)

    visit edit_task_path(task)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
