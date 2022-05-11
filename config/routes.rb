Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #APP 
  resources :juniors do 
    
    get '/sign_up_step2', to: 'adherents#signup_step2', as: 'signup_step2'
    resources :membre_requests
    
    resources :generated_documents

    resources :membres do
      resources :mandat_requests
      resources :mandats
    end

    resources :etudes do
      resources :phases do
        resources :document_phases
        resources :selection_intervenants, except: :index do
          resources :postulants do
            resources :document_postulants
          end
        end
        resources :intervenants do
          resources :document_intervenants
        end
      end
      resources :document_etudes
    end

    resources :selection_intervenants, only: :index do
      resources :postulants, only: :create
    end

    get '/mes_missions', to: 'selection_intervenants#mes_missions', as: 'mes_missions'
    get '/update_mode', to: 'juniors#update_mode', as: 'update_mode'

    resources :clients
    resources :adherents do
      resources :document_adherents
    end

    resources :junior_configurations do
      resources :config_doc_adherents
      resources :config_doc_etudes
      resources :poles
      resources :postes
      resources :permissions
      resources :prestations
      get '/archives', to: 'junior_configurations#archives', as: 'archives'
    end

    resources :tresoreries

    resources :user do
      resources :adherents do
        resources :document_adhesions
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

