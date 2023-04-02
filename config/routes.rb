Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'

  resources :tasks do
    member { patch :change_status }
  end
end
