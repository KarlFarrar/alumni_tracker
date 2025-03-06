Rails.application.routes.draw do
  namespace :admin do
    resources :alumni
    get 'dashboard', to: 'dashboard#index'  # This creates /admin/dashboard
    get 'dashboard/:id', to: 'dashboard#show', as: 'dashboard_show'
    get 'logs', to: 'logs#index', as: 'logs'
  end
  resources :alumni
  resources :change_logs, only: [:index]
  root 'alumni#index'
end
