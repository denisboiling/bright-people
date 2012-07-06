class ActivityPhoto < ActiveRecord::Base
  belongs_to :activity

  has_attached_file :attach, styles: { thumb: "100x100^#", slider: '530x370^#', large: '1000x1000^#' },
                             path: ":rails_root/public/system/activity_photos/:attachment/:id/:style/:filename",
                             url: "/system/activity_photos/:attachment/:id/:style/:filename",
                             default_style: :thumb, default_url: 'loading.gif'
  attr_accessible :attach, as: :admin
end
