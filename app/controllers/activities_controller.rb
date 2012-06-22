class ActivitiesController < ApplicationController
  load_and_authorize_resource

  # TODO: bugaggagga make it better, and try understand what every line do ;)
  before_filter :get_kind, only: :index
  before_filter :get_directions, only: :index
  before_filter :load_object, only: [:show, :get_comments, :vote]
  before_filter :check_published, only: :show

  def index
    @activity_page = true
    @activities = search
    @activities = @activities.page(params[:page]).per(15)
    if request.xhr?
      render partial: "activities/m_#{@kind}", locals: {activities: @activities}
    else
      render @kind
    end
  end

  def show
  end

  def vote
    ActivityVote.update_rating(current_user, @activity, params[:rating].to_f)
    render partial: 'vote_count'
  end

  def get_comments
    scope = params[:type] == 'parents' ? 'parents' : 'childrens'
    comments = @activity.activity_comments.send(scope).page(params[:page]).per(5)
    render partial: 'activity_comment', locals: {comments: comments}
  end

  def approve
    @activity = Activity.find(params[:activity_id])
    ActivityApproval.create! user_id: params[:expert_id],
    activity_id: @activity.id,
    text: params[:content]
    redirect_to @activity
  end

  private

  def load_object
    @activity = Activity.find(params[:id])
  end

  # OPTIMIZE:
  def search
    activities = Activity.by_kind(@kind).published
    activities = activities.approved if params[:only_approved].present?
    activities = activities.by_agerange(params[:age]) if params[:age].present?
    activities = activities.by_tag(params[:tag]) if params[:tag].present?
    activities = activities.by_metro(params[:metro]) if params[:metro].present?
    activities = activities.by_region(params[:region]) if params[:region].present?

    activities = case params[:order_by]
                 when 'title' then activities.order('title ASC')
                 when 'created_at' then activities.order('created_at DESC')
                 when 'users_rating' then activities.order('users_rating DESC')
                 else
                   activities.order('created_at DESC')
                 end

    activities
  end

  # TODO: create check params. More secure!!!
  def get_kind
    @kind = params[:kind] || 'educational'
  end

  def get_directions
    @directions = DirectionTag.send(@kind.to_sym)
  end

  def check_published
    return if current_admin_user
    redirect_to root_path unless @activity.published?
  end

end
