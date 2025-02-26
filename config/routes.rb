Rails.application.routes.draw do
  resources :alumni
  resources :change_logs, only: [:index]
  root 'alumni#index'
end
