Rails.application.routes.draw do

  resources :salary_reports
  resources :send_emails
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  root to:"salary_reports#new"
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
end
