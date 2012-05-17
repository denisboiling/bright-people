class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :ensure_email_existence
  
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
end
