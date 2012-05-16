BrightPeople::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  resources :organizations
  resources :activities
  
  root :to => 'home#show'
end
