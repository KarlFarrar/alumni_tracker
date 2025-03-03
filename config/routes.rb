Rails.application.routes.draw do
  root 'alumni#index'
  devise_for :gmails, controllers: { omniauth_callbacks:'gmails/omniauth_callbacks' }
  devise_scope :gmail do
    get 'gmails/sign_in', to: 'gmails/sessions#new', as: :new_gmail_session
    get 'gmails/sign_out', to: 'gmails/sessions#destroy', as: :destroy_gmail_session
  end
  resources :alumni
  resources :change_logs, only: [:index]
end
