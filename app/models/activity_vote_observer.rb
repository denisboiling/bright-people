class ActivityVoteObserver < ActiveRecord::Observer
  # TODO: move to delayed job
  def after_save(vote)
    vote.activity.update_rating!
  end
end
