require 'rails_helper'

RSpec.describe 'Tasks' do
  describe 'GET /tasks' do
    context 'when user is authenticated' do
      it 'returns http success' do
        user = create(:user)

        sign_in(user)
        get tasks_path

        expect(response).to have_http_status(:success)
      end

      it "displays user's tasks" do
        user = create(:user)
        tasks = create_list(:task, 3, user: user)

        sign_in(user)
        get tasks_path

        tasks.each do |task|
          expect(response.body).to include(task.title)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        get tasks_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /tasks/:id' do
    context 'when the user is authenticated' do
      it 'returns http success' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        get task_path(task)

        expect(response).to have_http_status(:success)
      end

      it 'renders show veiw' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        get task_path(task)

        expect(response).to render_template(:show)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        user = create(:user)
        task = create(:task, user: user)

        get edit_task_path(task)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /tasks/:id/edit' do
    context 'when the user is authenticated' do
      it 'returns http success' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        get edit_task_path(task)

        expect(response).to have_http_status(:success)
      end

      it 'renders edit veiw' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        get edit_task_path(task)

        expect(response).to render_template :edit
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        user = create(:user)
        task = create(:task, user: user)

        get edit_task_path(task)

        get edit_task_path(task)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /tasks/new' do
    it 'returns http success' do
      user = create(:user)

      sign_in(user)
      get new_task_path

      expect(response).to have_http_status(:success)
    end

    it 'renders new veiw' do
      user = create(:user)

      sign_in(user)
      get new_task_path

      expect(response).to render_template :new
    end
  end

  describe 'POST /tasks' do
    context 'with valid attributes' do
      it 'creates a new task for the user' do
        user = create(:user)

        sign_in(user)

        expect { post '/tasks', params: { task: attributes_for(:task) } }.to change(Task, :count).by(1)
      end

      it 'redirects to the tasks path' do
        user = create(:user)

        sign_in(user)
        post tasks_path, params: { task: attributes_for(:task) }

        expect(response).to redirect_to(tasks_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new task for the user' do
        user = create(:user)

        sign_in(user)

        expect { post tasks_path, params: { task: attributes_for(:task, :invalid) } }.not_to change(Task, :count)
      end

      it 'renders the new template' do
        user = create(:user)

        sign_in(user)
        post tasks_path, params: { task: attributes_for(:task, :invalid) }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT /tasks/:id' do
    context 'with valid attributes' do
      it 'updates the task' do
        user = create(:user)
        task = create(:task, user: user)
        new_task_attributes = attributes_for(:task, :new)

        sign_in(user)
        put task_path(task), params: { task: new_task_attributes }

        expect(response).to redirect_to(tasks_path)
      end

      it 'redirects to the all tasks page' do
        user = create(:user)
        task = create(:task, user: user)
        new_task_attributes = attributes_for(:task, :new)

        sign_in(user)
        put task_path(task), params: { task: new_task_attributes }
        follow_redirect!

        expect(response.body).to include(new_task_attributes[:title])
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit view' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        put task_path(task), params: { task: attributes_for(:task, :invalid) }

        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        user = create(:user)
        task = create(:task, user: user)

        put task_path(task), params: { task: { title: 'New title', description: 'New description' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    context 'when user is authenticated' do
      it 'deletes the task' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)

        expect { delete task_path(task) }.to change { user.tasks.count }.by(-1)
      end

      it 'redirects to all tasks page' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        delete task_path(task)

        expect(response).to redirect_to(tasks_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        user = create(:user)
        task = create(:task, user: user)

        delete task_path(task)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /tasks/:id/change_status' do
    context 'when author is authenticated' do
      it "changes task's is_done status" do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        expect { patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' } }.to change { task.reload.is_done? }
      end

      it 'renders change_status view' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' }

        expect(response).to render_template :change_status
      end

      it 'returns http success' do
        user = create(:user)
        task = create(:task, user: user)

        sign_in(user)
        patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' }

        expect(response).to have_http_status(:success)
      end
    end

    context 'when another user is authenticated' do
      it "does not change task's is_done status" do
        user = create(:user)
        task = create(:task, user: user)
        another_user = create(:user)

        sign_in(another_user)
        expect { patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' } }.not_to change { task.reload.is_done? }
      end

      it 'redirects to all tasks page' do
        user = create(:user)
        task = create(:task, user: user)
        another_user = create(:user)

        sign_in(another_user)
        patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' }

        expect(response).to redirect_to(tasks_path)
      end

      it 'returns status 302' do
        user = create(:user)
        task = create(:task, user: user)
        another_user = create(:user)

        sign_in(another_user)
        patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when user is not authenticated' do
      it 'returns status 401' do
        user = create(:user)
        task = create(:task, user: user)

        patch change_status_task_path(task), headers: { 'HTTP_ACCEPT' => 'text/javascript' }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
