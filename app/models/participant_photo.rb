class ParticipantPhoto < ActiveRecord::Base
  belongs_to :participant

  has_attached_file :attach, styles: { thumb: "100x100^#", slider: '530x370^#' },
                             path: ":rails_root/public/system/participant_photos/:attachment/:id/:style/:filename",
                             url: "/system/participant_photos/:attachment/:id/:style/:filename",
                             default_style: :thumb, default_url: 'loading.gif'
  attr_accessible :attach
end
