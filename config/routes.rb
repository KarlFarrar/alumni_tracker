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
  
  resources :alumni do
    member do
      post "claim_experiences"
      delete "remove_experience", to: "alumni#remove_experience"
      post 'claim_professions'
      delete 'remove_profession'
    end
  end

  resources :change_logs, only: [:index]
  resources :experiences
  resources :alumnus_experiences, only: [:edit, :update, :destroy]
  resources :experiences
  resources :professions
  resources :alumnus_professions, only: [:edit, :update, :destroy]
end
