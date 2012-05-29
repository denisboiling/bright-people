class ContestMembershipsController < ApplicationController
  def index
    @memberships = ContestMembership.where(contest_id: params[:contest_id])
  end
end
