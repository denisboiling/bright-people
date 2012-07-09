class Stage < ActiveRecord::Base
  attr_accessible :content, :small_pic, :large_pic, as: :admin

  has_attached_file :small_pic, styles: { thumb: '125x125^#' },
                           path: ":rails_root/public/stage/small/:attachment/:id/:style/:filename",
                           url: "/system/stage/small/:attachment/:id/:style/:filename",
                           default_style: :original

  has_attached_file :large_pic, styles: { thumb: '125x125^#' },
                           path: ":rails_root/public/stage/large/:attachment/:id/:style/:filename",
                           url: "/system/stage/large/:attachment/:id/:style/:filename",
                           default_style: :original

  validates :small_pic, :large_pic, presence: :true
end
