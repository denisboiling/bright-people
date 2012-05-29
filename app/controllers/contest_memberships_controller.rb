class ContestMembershipsController < ApplicationController
  before_filter :prepare
  
  def index
    @memberships = @contest.memberships
  end
  
  def show
    @membership = @contest.memberships.find(params[:id])
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
    return unless @contest.active?
    ContestVote.create user_id: current_user.id,
                       rate: params[:rate].to_i,
                       contest_id: params[:contest_id],
                       membership_id: params[:membership_id]
    head :ok
  end
  
  private
  
  def prepare
    @contest = Contest.find(params[:contest_id])
  end
end
