Rails.application.routes.draw do
  resources :alumni do
    post "claim_experience", on: :member
  end
  resources :change_logs, only: [:index]
  resources :experiences
  root 'alumni#index' 
end
