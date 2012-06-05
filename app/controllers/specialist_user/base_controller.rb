class SpecialistUser::BaseController < ApplicationController
  protect_from_forgery
  # OPTIMIZE: brrr... ugly
  before_filter :verify_specialist

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def verify_specialist
    redirect_to root_path unless can? :access, :specialist_dashboard
  end

end
