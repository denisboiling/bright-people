class ContestVoteObserver < ActiveRecord::Observer
  def after_create(vote)
    vote.membership.update_rating!
  end
end
