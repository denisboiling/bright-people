class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_or_create_for_vkontakte(request.env["omniauth.auth"])
    sign_in @user
    redirect_to '/'
  end

  def facebook
    @user = User.find_or_create_for_facebook(request.env["omniauth.auth"])
    sign_in @user
    redirect_to '/'
  end

  def odnoklassniki
    @user = User.find_or_create_for_odnoklassniki(request.env["omniauth.auth"])
    sign_in @user
    redirect_to '/'
  end
end
