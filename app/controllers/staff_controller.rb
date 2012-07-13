class StaffController < ApplicationController
  # TODO: only admin or moderator can do this
  # TODO: only admin or moderator can do this
  # TODO: only admin or moderator can do this

  def delete_video
    if VideoUrl.find(params[:object_id]).destroy
      head :ok
    else
      head :error
    end
  end

  def delete_photo
    return head(:bad_request) unless %w(ArticlePhoto NewsPhoto ParticipantPhoto ActivityPhoto).include?(params[:object_class])
    if params[:object_class].constantize.find(params[:object_id]).destroy
      head :ok
    else
      head :error
    end
  end

end
