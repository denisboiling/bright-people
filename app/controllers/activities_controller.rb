class ActivitiesController < ApplicationController
  # TODO: bugaggagga make it better, and try understand what every line do ;)
  before_filter :get_kind
  before_filter :get_directions, only: :index

  def index
    if request.xhr?
      @activities = search
      render partial: 'activities/activities', locals: {activities: @activities}
    else
      @activities = Activity.by_kind(@kind)
      # @activities = @activities.page(params[:page]).per(10)
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

  private

  def search
    activities = Activity.by_kind(@kind)
    activities = activities.approved if params[:only_approved].present?
    activities = activities.by_age(params[:age]) if params[:age].present?
    activities = activities.by_tag(params[:tag]) if params[:tag].present?
    activities = activities.by_metro(params[:metro]) if params[:metro].present?

    activities = case params[:order_by]
                 when 'title' then activities.order('title ASC')
                 when 'created_at' then activities.order('created_at DESC')
                 when 'users_rating' then activities.order('users_rating DESC')
                 else
                   activities.order('created_at DESC')
    end

    return activities
  end

  # TODO: create check params. More secure!!!
  def get_kind
    @kind = params[:kind] || 'educational'
  end

  def get_directions
    @directions = DirectionTag.send(@kind.to_sym)
  end

end
