Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #APP 
  resources :juniors do 
    resources :membre_requests
    resources :membres
    resources :user do
      resources :adherents
    end
  end

  #API V1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :etudes, only: [ :index, :show, :update ]
      get '/sessions', to: 'sessions#index', as: 'session'
      get '/userparams', to: 'userparams#index', as: 'userparam'
      get '/userparams/:id', to: 'userparams#update'
    end
  end
end
