Rails.application.routes.draw do
  resources :configs
  resources :keywords
  resources :signs
  resources :particles
  devise_for :users

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
