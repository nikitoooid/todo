describe 'User can delete his own tasks', "
  In order to remove unwanted tasks
  As an authenticated user
  I'd like to be able to delete my tasks
" do
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 3, user: user) }

  it 'Registred user can delete his own tasks', js:true do
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

  it 'Unregistered user cannot delete any tasks' do
    visit tasks_path

    tasks.each do |task|
      expect(page).not_to have_css("#task_#{task.id} button", text: 'Delete')
    end
  end
end
