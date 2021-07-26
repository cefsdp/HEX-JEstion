Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #APP 
  resources :juniors do 
  end

  #API V1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :etudes, only: [ :index, :show, :update ]
      get '/sessions', to: 'sessions#index', as: 'session'
    end
  end
end
