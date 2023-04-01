require 'rails_helper'

describe 'User can sign out' do
  it 'Signed in user tries to sign out' do
    user = create(:user)

    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
