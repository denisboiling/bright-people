class ParticipantsController < ApplicationController
  def index
    cat = params[:category]
    if cat != 'music_stage' and cat != 'doll_stage' and cat != 'circus_stage' and cat != 'street_theater' and cat != 'master_class' then
      cat = nil
    end
    if cat then
      @best = Participant.by_category(cat).first(3)
      @participants = Participant.by_category(cat)[3,Participant.by_category(cat).count]
    else
      @best = Participant.headliners.first(3)
      @participants = Participant.headliners[3,Participant.headliners.count]
    end
  end
end
