class ActivitiesController < ApplicationController
  def index
    @activities = Activity.scoped
    @activities = @activities.with_direction(params[:direction_tag_id])   if params[:direction_tag_id]
    @activities = @activities.with_ages(params[:age_tag_ids].split(','))  if params[:age_tag_ids]
    @activities = @activities.with_station(params[:metro_station_id])     if params[:metro_station_id]
    @activities =
      case params[:sort]
      when 'title'          then @activities.order(:title)
      when 'users_rating'   then @activities.order(:users_rating)
      when 'experts_rating' then @activities.order(:experts_rating)
      else                       @activities
      end
    @activities = @activities.distinct
  end
end
