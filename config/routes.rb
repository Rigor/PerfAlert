Rails.application.routes.draw do
  resources :scans, defaults: { format: :json }, except: :update
end
