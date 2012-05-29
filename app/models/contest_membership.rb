class ContestMembership < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  has_many :votes, class_name: 'ContestVote', foreign_key: :membership_id
  
  attr_accessible :name, :description, :picture
  
  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"
end
