class Dashboard::ProfilesController < Dashboard::BaseController
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

  def update
    current_user.update_attributes(params[:user])
    redirect_to dashboard_profile_path
  end

  def authors
    @authors = User.authors_with_photos.page(params[:page]).per(12)
  end

  def show 
  end
end
