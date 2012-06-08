class ExpertsController < ApplicationController
  def index
    @experts = User.experts
  end

  def show
    @expert = User.experts.find(params[:id])
  end
end
