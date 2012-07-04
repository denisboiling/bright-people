class ParticipantsController < ApplicationController
  def index
    cat = params[:category]
    if cat != 'music_stages' and cat != 'doll_stages' and cat != 'circus_stages' and cat != 'street_theaters' and cat != 'master_classes' then
      cat = nil
    end
    if cat then
      @best = Participant.by_category(cat).first(3)
      @participants = Participant.by_category(cat)[3,Participant.headliners.count]
    else
      @best = Participant.headliners.first(3)
      @participants = Participant.headliners[3,Participant.headliners.count]
    end
  end
end
