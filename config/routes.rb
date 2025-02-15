Rails.application.routes.draw do
  resources :alumni
  root 'alumni#index' 
end
