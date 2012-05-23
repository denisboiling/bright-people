BrightPeople::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  put 'users/email' => 'users#update_email', as: :update_user_email
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :organizations, only: [:show]
  resources :activities, only: [:index, :show] do
    put 'vote'
  end

  resource :search, only: [:show]
  resources :experts, only: [:index, :show]

  # Some staff match routes
  match '/staff/delete_photo_by_activity' => 'staff#delete_photo_by_activity', :via => :delete
  match '/staff/delete_video_by_activity' => 'staff#delete_video_by_activity', :via => :delete

  root :to => 'home#show'
end
