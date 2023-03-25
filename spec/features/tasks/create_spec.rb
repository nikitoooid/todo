require 'rails_helper'

describe 'User can create a task', "
  In order to remember what I want to do
  As an authenticated user
  I'd like to be able to create a tasks
" do
  let(:user) { create(:user) }

  it 'Registred user tries to create a task' do
    sign_in(user)
    visit new_task_path
    fill_in 'Title', with: 'My first task'
    click_on 'Create'

    expect(page).to have_content 'Your task successfully created.'
  end

  it 'Unregistred user can not create a task' do
    visit new_task_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
