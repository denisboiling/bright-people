class ActivityPhoto < ActiveRecord::Base
  belongs_to :activity

  has_attached_file :attach,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"

  attr_accessible :attach
end
