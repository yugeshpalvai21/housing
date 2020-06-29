Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'
  resources :houses
  resources :complex_buildings
  resources :commercial_units
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
