BrightPeople::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  put 'users/email' => 'users#update_email', as: :update_user_email

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :organizations, only: [:show]
  resources :activities, only: [:index, :show] do
    put 'vote'
  end

  resource :search, only: [:show]
  resources :experts, only: [:index, :show]
  resources :articles, only: [:index, :show] do
    resources :comments, only: [:create]
    collection do
      get :tag
    end
  end
  resources :article_categories, only: [:show]


  resources :specialists, only: [:index, :show, :create_question] do
    post :create_question, on: :member
  end

  resources :interviews, only: [:index, :show] do
    resources :comments, only: [:create]
    collection do
      get :tag
    end
  end

  resources :news, only: [:index, :show] do
    resources :comments
    collection do
      get :tag
    end
  end

  resources :special_projects, only: [:index, :show] do
    resources :comments
    collection do
      get :tag
    end
  end
  
  resources :contests, only: [:index, :show]

  # Specialist
  namespace :specialist do
    resources :questions
    root to: 'questions#index'
  end

  # Admin
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
