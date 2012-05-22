class ActivityVoteObserver < ActiveRecord::Observer
  def after_create(vote)
    vote.activity.update_rating!
  end
end
