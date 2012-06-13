class Dashboard::BaseController < ApplicationController
  load_and_authorize_resource :dashboard, class: false
end
