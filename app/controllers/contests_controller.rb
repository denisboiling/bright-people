class ContestsController < ApplicationController
  def index
    @contests =
      if category = ContestCategory.where(id: params[:category]).first
        category.contests
      else
        Contest.scoped
      end
  end
  
  def show
    @contest = Contest.find(params[:id])
  end

  def rules
    @contest = Contest.find(params[:id])
    render 'rules'
  end
end
