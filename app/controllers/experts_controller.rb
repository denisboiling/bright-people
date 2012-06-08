class ExpertsController < ApplicationController
  def index
    @experts = Role.expert.users
  end

  def show
    @expert = Role.expert.users.find(params[:id])
  end
end
