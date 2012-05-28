class ContestsController < ApplicationController
  def index
    @contests =
      if category = ContestCategory.where(id: params[:category]).first
        category.contests
      else
        Contest.scoped
      end
  end
end
