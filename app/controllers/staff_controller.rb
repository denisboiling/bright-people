class StaffController < ApplicationController
  # TODO: only admin or moderator can do this
  # TODO: only admin or moderator can do this
  # TODO: only admin or moderator can do this

  def add_video
    video_url = VideoUrl.new
    video_url.relation_type = params['object_class']
    video_url.relation_id = params['object_id']
    video_url.url = params['video_url']
    if video_url.save
      render :json => video_url.to_json
    else
      head :error
    end
  end

  def delete_video
    if VideoUrl.find(params[:object_id]).destroy
      render :json => 'ok'
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

  def get_categories
    @categories = DirectionTag.where(is_educational: params[:is_educational])
    render layout: false
  end

end
