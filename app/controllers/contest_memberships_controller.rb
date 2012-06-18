class ContestMembershipsController < ApplicationController
  before_filter :prepare

  def index
    @memberships = @contest.memberships

    sort = params[:sort]
    sort ||= 'created_at'

    @memberships = ContestMembership.order(sort)
    @memberships = @memberships.reject { |item| item.contest_id != @contest.id }
#   @memberships = @memberships.page(params[:page]).per(10)
    @memberships = Kaminari.paginate_array(@memberships).page(params[:page]).per(8)

    render partial: 'memberships_list', locals: { memberships: @memberships, contest: @contest } if params[:remote]
#   @memberships = @contest.memberships
  end

  def show
    @membership = @contest.memberships.find(params[:id])
    @comments = @membership.comments.top_level 
  end

  def new
    @membership = ContestMembership.new
  end

  def create
    @membership = ContestMembership.new
    @membership.contest_id = @contest.id
    @membership.user_id = current_user.id
    if @membership.update_attributes(params[:contest_membership])
      redirect_to contest_membership_path(@membership, contest_id: @contest.id)
    else
      render 'new'
    end
  end

  def vote
    throw "contest is not running #{@contest}" unless @contest.running?
    @membership = ContestMembership.find(params[:id])
    ContestVote.where(user_id: current_user.id,
                      membership_id: params[:id],
                      contest_id: params[:contest_id])
               .delete_all
    ContestVote.create! user_id: current_user.id,
                        membership_id: params[:id],
                        contest_id: params[:contest_id],
                        rate: params[:rating].to_i
    render partial: 'vote_count', locals: { membership: @membership }
  end

  private

  def prepare
    @contest = Contest.find(params[:contest_id])
  end
end
