class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_or_create_for_vkontakte(request.env["omniauth.auth"])
    sign_in_and_redirect @user, :event => :authentication
  end
end