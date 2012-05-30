class ContestMembership < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user

  has_many :votes, class_name: 'ContestVote', foreign_key: :membership_id

  attr_accessible :name, :description, :picture

  validates :picture, :user_id, :contest_id, presence: true

  has_many :comments, as: :relation

  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"

  def update_rating!
    votes = ContestVote.where(membership_id: id, contest_id: contest_id)
    rate = votes.average('rate')
    self.rating = rate
    self.save!
  end
end
