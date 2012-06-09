class UsersController < ApplicationController
  def update_email
    user = current_user
    user.email = params[:user][:email]
    if user.save and not user.email.blank?
      head :ok
    else
      render partial: 'users/email_form', locals: { user: user },
             status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if(@user.update_attributes(params[:user]))
      sign_in @user
      redirect_to profile_path
    else
    end
  end
end
