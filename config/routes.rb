Rails.application.routes.draw do
  resources :recent_headlines
  root to: 'signs#index'

  resources :news_hits
  resources :news_sources
  resources :configs
  resources :keywords
  resources :signs
  resources :particles
  post '/particles/login', to: 'particles#login'
  get '/admin/all_on', to: 'admin#all_on'
  get '/admin/all_off', to: 'admin#all_off'
  get '/admin/refresh_now', to: 'admin#refresh_now'
  devise_for :users

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
