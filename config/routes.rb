Rails.application.routes.draw do
  resources :recent_headlines
  root to: 'signs#index'

  resources :news_hits
  resources :news_sources
  resources :configs
  resources :keywords
  resources :signs
  resources :particle_instances
#  post '/particles/login', to: 'particles#login'
  get '/admin/all_on', to: 'admin#all_on'
  get '/admin/all_off', to: 'admin#all_off'
  get '/admin/refresh_now', to: 'admin#refresh_now'
  get '/relay/:id/:state', to: 'relay#activate'
  post '/signs/all_on', to: 'signs#all_on'
  post '/signs/all_off', to: 'signs#all_off'
  post '/signs/:id', to: 'signs#control'

  devise_for :users

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
