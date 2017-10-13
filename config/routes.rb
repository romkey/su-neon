Rails.application.routes.draw do
  root to: 'signs#index'

  resources :news_hits
  resources :news_sources
  resources :configs
  resources :keywords
  resources :signs
  resources :particles
  post '/particles/login', to: 'particles#login'
  devise_for :users

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
