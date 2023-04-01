require 'rails_helper'

describe 'User can delete his tasks', "
  In order to remove unwanted tasks
  As an authenticated user
  I'd like to be able to delete my tasks
" do
  describe 'Registred user', js: true do
    it 'can delete his tasks' do
      user = create(:user)
      tasks = create_list(:task, 3, user: user)

      sign_in(user)
      visit tasks_path

      tasks.each do |task|
        within("#task_#{task.id}") do
          accept_confirm do
            click_link 'Delete'
          end
        end

        expect(page).to have_content('Task has been deleted.')
        expect(page).not_to have_content(task.title)
      end
    end

    it "can't delete other user's tasks" do
      user = create(:user)
      another_user = create(:user)
      another_user_task = create(:task, user: another_user)

      sign_in(user)
      visit tasks_path

      expect(page).not_to have_css("#task_#{another_user_task.id} button", text: 'Delete')
    end
  end

  it 'Unregistered user cannot delete any tasks' do
    user = create(:user)
    tasks = create_list(:task, 3, user: user)

    visit tasks_path

    tasks.each do |task|
      expect(page).not_to have_css("#task_#{task.id} button", text: 'Delete')
    end
  end
end
