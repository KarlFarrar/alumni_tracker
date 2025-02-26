Rails.application.routes.draw do
  devise_for :users
  resources :alumni
  resources :change_logs, only: [:index]
  root 'alumni#index'
end
