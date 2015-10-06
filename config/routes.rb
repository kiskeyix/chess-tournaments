Rails.application.routes.draw do
  resources :leagues

  resources :rules

  # "shallow: true" allows for index, new, create to be deep nested,
  # :show, :edit, :update, :destroy to be shallow
  shallow do
    resources :tournaments do
      resources :divisions
    end
  end

  resources :players # players can be done outside of teams. Must come first
  shallow do
    resources :teams do
      member do
        delete 'remove_captain' => :remove_captain
        post 'make_captain' => :make_captain
      end
      resources :players
    end
  end

  get 'search' => 'search#index'
  devise_for :users, skip: :registrations,
    controllers: {
      omniauth_callbacks: 'omniauth_callbacks'
    }
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: {
        new: 'sign_up',
        sign_in: 'login',
        sign_out: 'logout',
      },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end
#   devise_for :users, path_names: {
#     sign_in: 'login',
#     sign_out: 'logout',
#   }, controllers: {
#     omniauth_callbacks: 'omniauth_callbacks'
#     }

  #post '/users/delete_identity/:id' => 'users#delete_identity'
  post '/users/delete_identity' => 'users#delete_identity'

  match '/users/:id/finish_signup' => 'users#finish_signup',
    via: [:get, :patch], :as => :finish_signup

  match '/users/link_player' => 'users#link_player',
    via: [:post], :as => :link_player

  get 'dashboard' => 'dashboard#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboard#index'
  resources :messages
end
