Rails.application.routes.draw do
  resources :alumni do
    member do
      delete "remove_experience", to: "alumni#remove_experience"
    end
    post "claim_experiences", on: :member
  end
  resources :change_logs, only: [:index]
  resources :experiences
  resources :alumnus_experiences, only: [:edit, :update, :destroy]
  root 'alumni#index' 
end
