class UsersController < ApplicationController
  def update_email
    user = current_user
    user.email = params[:user][:email]
    if user.save
      render head: :ok
    else
      render partial: 'users/email_form', locals: {user: user}, status: :unprocessable_entity
    end
  end
end
