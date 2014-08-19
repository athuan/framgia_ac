Rails.application.routes.draw do
  resources :salary_reports
  resources :send_emails
  root to:"salary_reports#new"
end
