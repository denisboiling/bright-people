class ParticipantsController < ApplicationController
  def index
    @best = Participant.headliners
    @participants = Participant.not_headliners
  end
end
