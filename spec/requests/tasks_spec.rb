require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  describe "GET /index" do
    
  end

  describe "GET /show" do
    
  end

  describe "GET /new" do
    before do
      sign_in user
      get '/tasks/new'
    end

    it 'renders new veiw' do
      expect(response).to render_template :new
    end
  end

  describe "POST /create" do
    before { sign_in user }

    context 'with valid attributes' do
      it 'saves a new task to database' do
        expect { post '/tasks', params: { task: attributes_for(:task) } }.to change(Task, :count).by(1)
      end

      it 'redirects to index view' do
        post '/tasks', params: { task: attributes_for(:task) }
        expect(response).to redirect_to tasks_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the task' do
        expect { post '/tasks', params: { task: attributes_for(:task, :invalid) } }.not_to change(Task, :count)
      end

      it 're-renders new view' do
        post '/tasks', params: { task: attributes_for(:task, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH /update" do
    
  end

  describe "DELETE /destroy" do
    
  end
end
