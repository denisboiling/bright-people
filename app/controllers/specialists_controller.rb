class SpecialistsController < ApplicationController
  def index
    @specialists = User.specialists.paginate(page: params[:page], per_page: 5)
  end

  def show
    @specialist = User.specialists.find(params[:id])
  end
end
