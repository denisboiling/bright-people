class ParticipantsController < ApplicationController
  def index
    cat = params[:category]
    if cat != 'music_stage' and cat != 'theater_stage' and cat != 'circus_stage' and cat != 'street_theater' and cat != 'master_class' then
      cat = nil
    end
    if cat then
      @stage = Stage.where(:category => cat).first
      @best = Participant.by_category(cat).first(3)
      @participants = Participant.by_category(cat)[3,Participant.by_category(cat).count]
      @is_headliners_page = false
    else
      @is_headliners_page = true
      @best = Participant.headliners.first(3)
      @participants = Participant.headliners[3,Participant.headliners.count]
    end
  end
end
