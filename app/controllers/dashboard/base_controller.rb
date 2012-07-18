class Dashboard::BaseController < ApplicationController
  protect_from_forgery

  load_and_authorize_resource :dashboard, class: false, :except => :authors
end
