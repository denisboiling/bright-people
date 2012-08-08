class GalleryPhoto < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_attached_file :photo, styles: {thumb: '100x100', medium: '530x370', big: '1366x768'},
                            path: ":rails_root/public/system/gallery_photos/:attachment/:id/:style/:filename",
                            url: "/system/gallery_photos/:attachment/:id/:style/:filename",
                            default_style: :thumb, default_url: 'loading.gif'

  attr_accessible :user_id, :photo

  validates :photo_fingerprint, presence: true, uniqueness: true

  after_save :add_shot_date

  def add_shot_date
    self.update_column(:shot_date, Time.now) unless File.exist?(self.photo.path(:original))
    self.update_column(:shot_date, EXIFR::JPEG.new(self.photo.path(:original)).date_time)
  end

  def to_jq_upload
    {
      "name" => read_attribute(:photo_name),
      "size" => photo.size,
      "url" => photo.url,
      "thumbnail_url" => photo.url(:thumb),
      "delete_url" => dashboard_photo_path(id),
      "delete_type" => "DELETE"
    }
  end
end
