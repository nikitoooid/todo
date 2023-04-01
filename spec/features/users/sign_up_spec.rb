require 'rails_helper'

describe 'User can sign up', "
  In order create tasks
  As an unauthenticated user
  I'd like to be able to sign up
" do
  it 'Unregistred user tries to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'Registred user tries to sign up' do
    user = create(:user)

    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'prohibited this user from being saved'
  end
end
