class ActivityComment < ActiveRecord::Base
  attr_accessible :content, :commentator, :picture, :isParent, :activity_id, :activity

  belongs_to :activity

  has_attached_file :picture,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
end
