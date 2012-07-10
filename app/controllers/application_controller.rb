class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_url_for_fb
  after_filter :ensure_email_existence
  after_filter :current_user_presence

  #rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url, :alert => exception.message
  #end
  
  # check current user for email
  # if none, then it sets apropriate flag into cookie
  # to show dialog to enter email.
  def ensure_email_existence
    if current_user and current_user.email.blank?
      cookies[:email_dialog] = true
    else
      cookies.delete :email_dialog
    end
  end
  
  # checks is user logged in, if so then it writes user's id to cookies
  def current_user_presence
    if current_user
      cookies[:current_user] = current_user.id
    else
      cookies.delete :current_user
    end
  end
  
  def set_url_for_fb
    @fb_url = request.url
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_admin_user)
  end
end
