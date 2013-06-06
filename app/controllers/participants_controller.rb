class ParticipantsController < ApplicationController
  def index
    year = params[:year] || Time.now.year
    category = params[:category]
    category = nil unless category.in? Stage.pluck(:category)
    if category
      @stage = Stage.where(year: year).by_category_name(category)
      @best = Participant.where(year: year).best(category)
      @participants = Participant.by_category_unless(category, @best)
      @is_headliners_page = false
    else
      @is_headliners_page = true
      @best = Participant.where(year: year).headliners.sample(3)
      @participants = Participant.headliners_unless(@best)
    end
    @participants = @participants.where(year: year)
    @year = year unless year == Time.now.year
  end
end
