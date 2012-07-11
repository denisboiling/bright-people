class UsersController < ApplicationController
  load_and_authorize_resource :dashboard, class: false, :except => :authors

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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    redirect_to dashboard_profile_path
  end

  def notifications
    @notifications = current_user.notifications.order('created_at DESC').page(1).per(16)
  end

  def authors
    @authors = User.authors_with_photos.page(params[:page]).per(12)
  end
end
