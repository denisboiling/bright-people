class Contest < ActiveRecord::Base
  belongs_to :category, class_name: 'ContestCategory'
  has_many :memberships, class_name: 'ContestMembership'
  has_many :votes, class_name: 'ContestVote'
  
  attr_accessible :name, :started_at, :ended_at, :description, :picture, :category_id
  
  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"
  
  def active?
    now = DateTime.now
    (started_at < now) and (now < ended_at)
  end
end
