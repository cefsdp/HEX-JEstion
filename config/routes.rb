Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #APP 
  resources :juniors do 

    resources :membre_requests
    
    resources :membres do
      resources :mandat_requests do
        resources :mandats
      end
    end

    resources :etudes do
      resources :etapes
      resources :phases
    end

    resources :clients
    resources :adherents

    resources :junior_configurations do
      resources :config_doc_adherents
      resources :poles
      resources :postes
      resources :permissions
      get '/archives', to: 'junior_configurations#archives', as: 'archives'
    end

    resources :user do
      resources :adherents do
        resources :document_adherents
      end
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

  # Sidekiq
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

