BrightPeople::Application.routes.draw do
  match '/crew' => 'crew#index'
  match '/authors' => 'users#authors'
  match '/vk' => 'vk_pages#create_vk_page'
  match '/vk_token' => 'vk_pages#auth'
  match '/fb' => 'fb_pages#fb_auth'
  match '/fb_pages' => 'fb_pages#fb_pages'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  put 'users/email' => 'users#update_email', as: :update_user_email

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :news, only: [:index, :show] do
    collection do
      get :tag
    end
  end
  resources :creative_group, only: [:index, :show]
  resources :organizations, only: [:show]
  resources :experts, only: [:index, :show]
  resources :sponsors, only: [:index, :show]
  resources :participants, only: [:index]

  resource :comments, only: :create
  resource :search, only: [:show]

  resources :activities, only: [:index, :show, :search] do
    get :get_comments
    put :approve
  end
  match '/activities/search' => 'activities#search', :via => :post, :as => :activity_search
  match '/activities/vote' => 'activities#vote', :via => :put

  resources :articles, only: [:index, :show] do
    resource :archive, only: :show
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
    get 'rules', on: :member
  end

  # User dashboard
  namespace :dashboard do
    resource :profile, only: [:show, :update]
    resources :favorites, only: [:index, :create, :destroy]
    resources :comments, only: :index
    resources :photos, only: [:index, :create, :destroy]
    resource :activity do
      delete 'destroy_teacher', on: :member
    end
    root to: "profile#show"
  end

  # Admin panel
  namespace :admin do
    resources :activities do
      get :get_categories, :on => :collection
      get :autocomplete, :on => :collection
    end
    resources :organizations do
      get :autocomplete_organization_title, :on => :collection
    end
  end

  # Some staff match routes
  match '/staff/delete_photo' => 'staff#delete_photo', :via => :delete
  match '/staff/delete_video' => 'staff#delete_video', :via => :delete
  match '/staff/add_video' => 'staff#add_video', :via => :post
  match '/staff/get_categories' => 'staff#get_categories'

  root :to => 'home#show'

  # TODO: dirty and don't why why migrate is broken?
  ActiveAdmin.routes(self) if ActiveRecord::Base.connection.table_exists?(:activity_comments)
end
