class Participant < ActiveRecord::Base
  default_scope :order => 'priority DESC'

  has_attached_file :logo, styles: { medium: "300x300^#", thumb: '160x100^#', approved: '422x114^#', index: '186x114^#',
                                     participants_page: "420x263#" },
                           path: ":rails_root/public/system/participants/:attachment/:id/:style/:filename",
                           url: "/system/participants/:attachment/:id/:style/:filename",
                           default_style: :thumb, default_url: 'loading.gif'

  has_many :photos, class_name: 'ParticipantPhoto',
                    dependent: :destroy

  has_many :videos, class_name: 'VideoUrl', as: :relation, dependent: :destroy

  scope :headliners, where(headliner: true)
  scope :headliners_unless, lambda{ |_headliners| where('headliner = ? AND id NOT IN (?)', true, _headliners.map(&:id)) }

  scope :not_headliners, where(headliner: false)

  scope :by_category, lambda { |category| where(category: category) }
  scope :by_category_unless, lambda { |category, exists| where('category = ? AND id NOT IN (?)', category, exists.map(&:id)) }

  validates :title, :description, :logo, presence: :true

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

  attr_accessible :title, :description, :logo, :photos_attributes, :videos_attributes, 
                  :headliner, :category, :priority, :year


  class << self
    def best(_category)
      by_category(_category).take(3)
    end
  end

end
