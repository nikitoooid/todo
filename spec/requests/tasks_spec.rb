require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  describe "GET /index" do
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

  describe "GET /show" do
    
  end

  describe "GET /new" do
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

  describe "POST /create" do
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

    # context 'with valid attributes' do
    #   it 'saves a new task to database' do
    #     expect { post '/tasks', params: { task: attributes_for(:task) } }.to change(Task, :count).by(1)
    #   end

    #   it 'redirects to index view' do
    #     post '/tasks', params: { task: attributes_for(:task) }
    #     expect(response).to redirect_to tasks_path
    #   end
    # end

    # context 'with invalid attributes' do
    #   it 'does not save the task' do
    #     expect { post '/tasks', params: { task: attributes_for(:task, :invalid) } }.not_to change(Task, :count)
    #   end

    #   it 're-renders new view' do
    #     post '/tasks', params: { task: attributes_for(:task, :invalid) }
    #     expect(response).to render_template :new
    #   end
    # end
  end

  describe "PATCH /update" do
    
  end

  describe "DELETE /destroy" do
    
  end
end
