require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  describe "GET /tasks" do
    let!(:tasks) { create_list(:task, 3, user: user) }

    context "when user is authenticated" do
      before do
        sign_in user
        get tasks_path
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "displays user's tasks" do
        tasks.each do |task|
          expect(response.body).to include(task.title)
        end
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get tasks_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /tasks/:id/edit" do
    context "when the user is authenticated" do
      before {
        sign_in(user)
        get edit_task_path(task)
      }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
  
      it "renders edit veiw" do
        expect(response).to render_template :edit
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign in page" do
        get edit_task_path(task)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /tasks/new" do
    before do
      sign_in user
      get '/tasks/new'
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders new veiw' do
      expect(response).to render_template :new
    end
  end

  describe "POST /tasks" do
    before { sign_in user }

    context "with valid attributes" do
      let(:task_attributes) { attributes_for(:task) }

      it "creates a new task for the user" do
        expect { post '/tasks', params: { task: attributes_for(:task) } }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks path" do
        post tasks_path, params: { task: task_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new task for the user" do
        expect { post tasks_path, params: { task: attributes_for(:task, :invalid) } }.not_to change(Task, :count)
      end

      it "renders the new template" do
        post tasks_path, params: { task: attributes_for(:task, :invalid) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT /tasks/:id" do
    context "when the user is authenticated" do
      before { sign_in(user) }

      context "with valid attributes" do
        let(:new_task_attributes) { attributes_for(:task, :new) }

        it "updates the task and redirects to the all tasks page" do
          put task_path(task), params: { task: new_task_attributes }
          expect(response).to redirect_to(tasks_path)
          follow_redirect!
          expect(response.body).to include(new_task_attributes[:title])
        end
      end

      context 'with invalid parameters' do
        it 'renders the edit view' do
          put task_path(task), params: { task: attributes_for(:task, :invalid) }
          expect(response).to render_template(:edit)
        end
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign in page" do
        put task_path(task), params: { task: { title: 'New title', description: 'New description' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE /tasks/:id" do
    context "when user is authenticated" do
      before { sign_in(user) }

      it "deletes the task" do
        expect { delete task_path(task) }.to change { user.tasks.count }.by(-1)
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign in page" do
        delete task_path(task)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
