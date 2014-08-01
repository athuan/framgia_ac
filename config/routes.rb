Rails.application.routes.draw do
  root to:"excels#index", via: :get
  match "excels", to: "excels#index", via: :get
  match "excels/import", to: "excels#import", via: :post
end
