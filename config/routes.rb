BrightPeople::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :organizations
  resources :activities

  root :to => 'home#show'
end
