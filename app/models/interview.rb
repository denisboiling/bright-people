class Interview < ActiveRecord::Base
  attr_accessible :title, :content, :interview_tag_list, :picture, :short_description, :author_id, :review, :review_title, :is_enabled

  acts_as_taggable_on :interview_tags

  validates :title, :content, :author, presence: :true

  has_many :comments, as: :relation
  belongs_to :author, class_name: 'User'

  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "160x100>" },
                    path: ":rails_root/public/system/interviews/:attachment/:id/:style/:filename",
                    url: "/system/interviews/:attachment/:id/:style/:filename",
                    default_style: :thumb

  class << self
    def for_main
      order('created_at DESC').first(5)
    end
  end
end
