Rails.application.routes.draw do
  root to:"excels#index", via: :get
  match "excels", to: "excels#index", via: :get
  match "excels/import", to: "excels#import", via: :post
  match "excels/list_user", to: "excels#list_user", via: :get
  match "excels/sent_email", to: "excels#sent_email", via: :get
  match "excels/sent_all", to: "excels#sent_all", via: :get
  match "excels/download", to: "excels#download", via: :get
end
