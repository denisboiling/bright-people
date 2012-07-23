class ParticipantsController < ApplicationController
  # OPTIMIZE: this is shit, really
  def index
    category = params[:category]
    category = nil unless %w(music_stage theater_stage circus_stage street_theater master_class).include?(category)
    if category then
      @stage = Stage.by_category_name(category)
      @best = Participant.best(category)
      @participants = Participant.by_category_unless(category, @best)
      @is_headliners_page = false
    else
      @is_headliners_page = true
      @best = Participant.headliners.sample(3)
      @participants = Participant.headliners_unless(@best)
    end
  end
end
