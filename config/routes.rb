Rails.application.routes.draw do
  root 'directory/alumni#index'
  devise_for :gmails, controllers: { registrations: 'gmails/registrations', omniauth_callbacks:'gmails/omniauth_callbacks' }
  devise_scope :gmail do
    get 'gmails/sign_in', to: 'gmails/sessions#new', as: :new_gmail_session
    get 'gmails/sign_out', to: 'gmails/sessions#destroy', as: :destroy_gmail_session
    get 'gmails/choose_role', to: 'gmails/registrations#choose_role', as: :choose_role_registration
    post 'gmails', to: 'gmails/registrations#create', as: :create_gmail
  end

  namespace :directory do
    resources :alumni, only: [:index, :show]
    resources :students, only: [:index, :show]
  end
  
  get 'user_guide', to: 'user_guide#index', as: 'user_guide'
  
  resources :alumni, except: [:index] do
    member do
      post "claim_experiences"
      delete "remove_experience", to: "alumni#remove_experience"
      post 'claim_professions'
      delete 'remove_profession'
      get :complete_profile
    end
  end

  resources :students, except: [:index] do
    member do 
      post "claim_experiences"
      delete "remove_experiences", to: "students#remove_experience"
    end
  end

  get 'directory/students', to: 'students#index', as: 'student_directory'

  namespace :admin do
    resources :alumni
    resources :users do
      post :give_admin, on: :member
    end
    resources :experiences
    resources :professions, only: [:index, :create, :destroy]
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'  # This creates /admin/dashboard
    get 'dashboard/:id', to: 'dashboard#show', as: 'dashboard_show'
    get 'logs', to: 'logs#index', as: 'logs'
  end

  resources :change_logs, only: [:index]
  resources :experiences
  resources :alumnus_experiences, only: [:edit, :update, :destroy]
  resources :experiences
  resources :professions
  resources :alumnus_professions, only: [:edit, :update, :destroy]
  resources :student_experiences, only: [:edit, :update, :destroy]
end
