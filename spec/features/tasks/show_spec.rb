require 'rails_helper'

describe 'User can view a task', "
  In order to see the details of a task
  As an authenticated user
  I'd like to be able to view a task
" do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let(:other_user) { create(:user) }
  let!(:other_task) { create(:task, user: other_user) }

  describe 'Registred user' do
    before { sign_in(user) }

    it 'can view his own task' do
      visit task_path(task)
      expect(page).to have_content(task.title)
    end

    it "can not see other user's task" do
      visit task_path(other_task)
      expect(page).not_to have_content(other_task.title)
    end
  end

  it "Unregistred user can't see any tasks" do
    visit task_path(task)
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
