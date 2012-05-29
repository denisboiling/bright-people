class ContestMembershipsController < ApplicationController
  before_filter :prepare
  
  def index
    @memberships = @contest.memberships
  end
  
  def show
    @membership = @contest.memberships.find(params[:id])
  end
  
  private
  
  def prepare
    @contest = Contest.find(params[:contest_id])
  end
end
