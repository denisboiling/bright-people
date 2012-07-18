class Dashboard::CommentsController < Dashboard::BaseController
  def index
    @notifications = current_user.notifications.order('created_at DESC').page(1).per(16)
  end
end
