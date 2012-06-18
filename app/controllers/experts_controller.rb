class ExpertsController < ApplicationController
  def index
    @expert_page = true
    @experts = User.experts
  end

  def show
    @expert = User.experts.find(params[:id])
  end
end
