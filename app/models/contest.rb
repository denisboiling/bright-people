class Contest < ActiveRecord::Base
  belongs_to :category, class_name: 'ContestCategory'
  
  attr_accessible :name, :started_at, :ended_at
  
  def active?
    now = DateTime.now
    (started_at < now) and (now < ended_at)
  end
end
