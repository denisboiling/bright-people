class UsersController < ApplicationController
  def update_email
    user = current_user
    user.email = params[:user][:email]
    if user.save and not user.email.blank?
      head :ok
    else
      render partial: 'users/email_form', locals: {user: user}, status: :unprocessable_entity
    end
  end
end
