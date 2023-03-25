require 'rails_helper'

describe 'User can see all his tasks', "
  In order to remember what I want to do
  As an authenticated user
  I'd like to be able to see all my tasks
" do
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 3, user: user) }

  it 'Registred user see all his tasks' do
    sign_in(user)
    visit tasks_path

    tasks.each do |task|
      expect(page).to have_content(task.title)
    end
  end

  it 'Unregistred user can not see any tasks' do
    visit tasks_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
