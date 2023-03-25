require 'rails_helper'

describe 'User can delete his tasks', "
  In order to remove unwanted tasks
  As an authenticated user
  I'd like to be able to delete my tasks
" do
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 3, user: user) }
  let(:another_user) { create(:user) }
  let!(:another_user_task) { create(:task, user: another_user) }

  describe 'Registred user', js: true do
    before do
      sign_in(user)
      visit tasks_path
    end

    it 'can delete his tasks' do
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
      expect(page).not_to have_css("#task_#{another_user_task.id} button", text: 'Delete')
    end
  end

  it 'Unregistered user cannot delete any tasks' do
    visit tasks_path

    tasks.each do |task|
      expect(page).not_to have_css("#task_#{task.id} button", text: 'Delete')
    end
  end
end
