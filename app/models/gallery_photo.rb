class GalleryPhoto < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_attached_file :photo, styles: {thumb: '100x100', medium: '530x370', big: '1366x768'},
                            path: ":rails_root/public/system/gallery_photos/:attachment/:id/:style/:filename",
                            url: "/system/gallery_photos/:attachment/:id/:style/:filename",
                            default_style: :thumb,
                            default_url: 'loading.gif'


  attr_accessible :user_id, :photo

  validates :photo_fingerprint, presence: true, uniqueness: true

  after_save :add_shot_date

  def add_shot_date
    date = EXIFR::JPEG.new(self.photo.path(:original)).date_time rescue Time.zone.now
    self.update_column(:shot_date, date)
  end

  def to_jq_upload
    {
      "name" => read_attribute(:photo_name),
      "size" => photo.size,
      "url" => photo.url,
      "thumbnail_url" => '/assets/loading.gif',
      "delete_url" => dashboard_photo_path(id),
      "delete_type" => "DELETE"
    }
  end

  before_photo_post_process do
    self.processing ? false : true
  end

  after_create do
    self.delay.perform
  end

  # Regenerate thumbs
  def perform
    self.processing = false
    photo.reprocess!
    save
  end

end
