class ActivitiesController < ApplicationController
  # TODO: integrate metasearch for sorting

  def index
    @activities = Activity.with_direction(params[:direction_tag_id])
                          .with_station(params[:metro_station_id])
                          .with_users_rating(params[:users_rating_start], params[:users_rating_end])
                          .with_experts_rating(params[:experts_rating_start], params[:experts_rating_end])
                          .order(params[:sort])
    @activities = @activities.with_ages(params[:age_tag_ids].split(','))  if params[:age_tag_ids]
    @activities = @activities.distinct

    @directions =
      case params[:kind]
      when 'educational'    then DirectionTag.educational
      when 'entertainment'  then DirectionTag.entertainment
      else                       DirectionTag.scoped
      end

    if params[:remote]
      render partial: 'activities', locals: {activities: @activities}
    end
  end

  def show
    @activity = Activity.find(params[:id])
  end
  
  def vote
    ActivityVote.create user_id: current_user.id,
                        rate: params[:rate].to_i,
                        activity_id: params[:activity_id]
    head :ok
  end
end
