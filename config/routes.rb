Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'

  resources :tasks do
    member { patch :change_status }
    collection { get :search }
  end
end
