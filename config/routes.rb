Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'
  resources :houses do
    member do
      get 'buy'
    end
  end

  resources :complex_buildings do
    member do
      get 'buy'
    end
  end

  resources :commercial_units do
    member do
      get 'buy'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
