BrightPeople::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  put 'users/email' => 'users#update_email', as: :update_user_email

  devise_for :admin_users, ActiveAdmin::Devise.config

  # TODO: move to dashboard
  get '/profile' => 'users#show'
  get '/profile/edit' => 'users#edit'

  resources :users, only: [:show, :update]
  resources :organizations, only: [:show]
  resource :search, only: [:show]
  resources :experts, only: [:index, :show]
  resources :sponsors, only: [:index, :show]
  resources :favourites, only: [:index, :create, :destroy]
  resource :comments, only: :create

  resources :activities, only: [:index, :show, :search] do
    put 'vote'
  end
  match '/activities/search' => 'activities#search', :via => :post, :as => :activity_search

  resources :articles, only: [:index, :show] do
    collection do
      get :tag
    end
  end
  resources :article_categories, only: [:show]

  resources :interviews, only: [:index, :show] do
    collection do
      get :tag
    end
  end

  resources :news, only: [:index, :show] do
    collection do
      get :tag
    end
  end

  resources :special_projects, only: [:index, :show] do
    collection do
      get :tag
    end
  end

  resources :contests, only: [:index, :show] do
    resources :contest_memberships, path: "members",
                                    only: [:index, :show, :new, :create],
                                    as: :memberships do
      put :vote
    end
  end

  # User dashboard
  namespace :dashboard do
    resources :notifications, only: [:index, :destroy, :update]
  end

  # Admin panel
  namespace :admin do
    resources :activities do
      get :autocomplete_activity_title, :on => :collection
    end
    resources :organizations do
      get :autocomplete_organization_title, :on => :collection
    end
  end

  ActiveAdmin.routes(self)

  # Some staff match routes
  match '/staff/delete_photo_by_activity' => 'staff#delete_photo_by_activity', :via => :delete
  match '/staff/delete_video_by_activity' => 'staff#delete_video_by_activity', :via => :delete

  root :to => 'home#show'


end
