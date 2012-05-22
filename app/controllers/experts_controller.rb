class ExpertsController < ApplicationController
  def index
    @experts = Expert.all
  end

  def show
    @expert = Expert.find(params[:id])
  end
end
