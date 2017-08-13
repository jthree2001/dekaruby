Rails.application.routes.draw do
  root to: 'denizens#index'

  get '/startworker', to: 'denizens#startworker'
  resources :denizens
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
