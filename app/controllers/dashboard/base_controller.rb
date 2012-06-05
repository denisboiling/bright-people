class Dashboard::BaseController < ApplicationController
  protect_from_forgery
  # OPTIMIZE: brrr... ugly
  before_filter :verify_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def verify_user
    redirect_to root_path unless can? :access, :dashboard
  end

end
