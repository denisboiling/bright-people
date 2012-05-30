class Dashboard::NotificationsController < Dashboard::BaseController
  def index
    @notifications = current_user.comment_notifies.order('created_at DESC')
  end

  def destroy
  end

  def update
  end
end
