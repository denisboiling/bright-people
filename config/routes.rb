BrightPeople::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  put 'users/email' => 'users#update_email', as: :update_user_email

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :users, only: [:show, :update]
  resources :organizations, only: [:show]
  resources :experts, only: [:index, :show]
  resources :sponsors, only: [:index, :show]
  resources :favourites, only: [:index, :create, :destroy]

  resource :comments, only: :create
  resource :search, only: [:show]

  resources :activities, only: [:index, :show, :search] do
    get :get_comments
    put :approve
  end
  match '/activities/search' => 'activities#search', :via => :post, :as => :activity_search
  match '/activities/vote' => 'activities#vote', :via => :put

  resources :articles, only: [:index, :show] do
    collection do
      get :tag
    end
  end
  resources :article_categories, only: [:show]

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

  get "/contests/:id/rules" => "contests#rules"

  # User dashboard
  scope 'dashboard' do
    get 'notifications' => 'users#notifications', as: :dashboard_notifications
    get 'favourites' => 'favourites#index', as: :dashboard_favourites
    get 'profile' => 'users#edit', as: :dashboard_profile
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

  # Some staff match routes
  match '/staff/delete_photo_by_activity' => 'staff#delete_photo_by_activity', :via => :delete
  match '/staff/delete_video_by_activity' => 'staff#delete_video_by_activity', :via => :delete

  root :to => 'home#show'

  # TODO: dirty and don't why why migrate is broken?
  ActiveAdmin.routes(self) if ActiveRecord::Base.connection.table_exists?(:activity_comments)
end
