class Participant < ActiveRecord::Base
  has_attached_file :logo, styles: { medium: "300x300^#", thumb: '160x100^#', approved: '422x114^#', index: '186x114^#' },
                           path: ":rails_root/public/system/participants/:attachment/:id/:style/:filename",
                           url: "/system/participants/:attachment/:id/:style/:filename",
                           default_style: :thumb, default_url: 'loading.gif'

  has_many :photos, class_name: 'ParticipantPhoto',
                    dependent: :destroy

  has_many :videos, class_name: 'VideoUrl', dependent: :destroy,
                    conditions: "relation_type = 'participant'",
                    foreign_key: 'relation_id', before_add: :add_participant_type

  scope :headliners, where(headliner: true)
  scope :not_headliners, where(headliner: false)

  validates :title, :description, :logo, presence: :true
  validate :must_be_not_more_than_3_headliners

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

  attr_accessible :title, :description, :logo, :photos_attributes, :videos_attributes, :headliner, as: :admin

  def add_participant_type(video)
    video.relation_type = 'participant'
  end

  def must_be_not_more_than_3_headliners
    if headliner and Participant.headliners.count >= 3 
      errors.add(:headliner, "Too many headliners - 3 maximum")
    end
  end
end
