Rails.application.routes.draw do
  root 'alumni#index'
  devise_for :gmails, controllers: { registrations: 'gmails/registrations', omniauth_callbacks:'gmails/omniauth_callbacks' }
  devise_scope :gmail do
    get 'gmails/sign_in', to: 'gmails/sessions#new', as: :new_gmail_session
    get 'gmails/sign_out', to: 'gmails/sessions#destroy', as: :destroy_gmail_session
    get 'gmails/sign_up', to: 'gmails/registrations#new', as: :new_gmail_registration
    get 'gmails/choose_role', to: 'gmails/registrations#choose_role', as: :choose_role_registration
    post 'gmails', to: 'gmails/registrations#create', as: :create_gmail
  end

  namespace :admin do
    resources :alumni
    get 'dashboard', to: 'dashboard#index'  # This creates /admin/dashboard
    get 'dashboard/:id', to: 'dashboard#show', as: 'dashboard_show'
    get 'logs', to: 'logs#index', as: 'logs'
  end
  resources :alumni
  resources :change_logs, only: [:index]
end
