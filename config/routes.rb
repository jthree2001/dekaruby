Rails.application.routes.draw do
  root to: 'landing#index'

  get '/startworker', to: 'landing#startworker'
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  resources :denizens
  resources :landing
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
