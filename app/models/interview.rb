class Interview < ActiveRecord::Base
  attr_accessible :title, :content, :author, :interview_tag_list, :picture

  acts_as_taggable_on :interview_tags

  validates :title, :content, :author, presence: :true

  has_many :comments, as: :relation

  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"
end
