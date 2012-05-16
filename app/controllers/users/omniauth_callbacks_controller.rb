class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_or_create_for_vkontakte(request.env["omniauth.auth"])
    sign_in @user
    redirect_to root_url
  end
end