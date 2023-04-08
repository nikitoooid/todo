require 'rails_helper'

describe 'User can search tasks', "
  In order to find a specific task
  As an authenticated user
  I'd like to be able to search tasks by keywords
" do
  describe 'Registred user' do
    it 'searches by keyword', js: true do
      user = create(:user)
      create(:task, title: 'Write tests', user: user)
      create(:task, title: 'Refactor code', user: user)

      sign_in(user)
      visit tasks_path

      fill_in 'q', with: 'tests'
      click_button 'Search'

      expect(page).to have_content 'Write tests'
      expect(page).not_to have_content 'Refactor code'
    end
  end
end
