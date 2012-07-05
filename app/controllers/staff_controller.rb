class StaffController < ApplicationController
  # TODO: only admin or moderator can do this
  # OPTIMIZE: maybe combine 2 action in one?
  def delete_photo_by_activity
    ActivityPhoto.find(params[:id]).destroy
    render nothing: true
  end

  def delete_video_by_activity
    VideoUrl.find(params[:id]).destroy
    render nothing: true
  end

  def delete_photo_by_participant
    ParticipantPhoto.find(params[:id]).destroy
    render nothing: true
  end

  def delete_video_by_participant
    VideoUrl.find(params[:id]).destroy
    render nothing: true
  end
end
