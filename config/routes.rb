Rails.application.routes.draw do
  resources :houses
  resources :complex_buildings
  resources :commercial_units
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
