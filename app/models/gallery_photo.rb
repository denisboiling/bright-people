class GalleryPhoto < ActiveRecord::Base
  require 'zip/zip'

  include Rails.application.routes.url_helpers

  belongs_to :user

  has_attached_file :photo, styles: {thumb: '100x100', medium: '530x370', big: '1366x768'},
                            path: ":rails_root/public/system/gallery_photos/:attachment/:id/:style/:filename",
                            url: "/system/gallery_photos/:attachment/:id/:style/:filename",
                            default_style: :thumb,
                            default_url: 'loading.gif'

  attr_accessible :user_id, :photo

  validates :photo_fingerprint, presence: true, uniqueness: true
  validates :user, presence: true

  scope :published, where(processing: false)

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
    # TODO: remove this dirty hack about test env
    if Rails.env.test?
      self.processing = true
      true
    end
  end

  after_create do
    # TODO: remove dirty hack about test evn
    self.delay.perform unless Rails.env.test?
  end

  # Regenerate thumbs
  def perform
    self.processing = false
    photo.reprocess!
    save
  end

  class << self

    # We can send to this method params:
    # GalleryPhoto.first.last || [GalleryPhoto.first.first GalleryPhoto.first.last] || [1, 2, 3]
    def create_archive(photos)
      # Generate random arhive name. If arhive already exist, create with another name
      def create_archive_dir
        dir = File.join(@public_dir, 24.times.map{ ('a'..'z').to_a[rand(26)] }.join)
        create_archive_dir if File.exist?(dir)
        dir
      end

      @public_dir = Rails.root.join('public/arhives')
      FileUtils.mkdir_p(@public_dir) unless File.exist?(@public_dir)
      arhive_dir = create_archive_dir

      photos = [photos] if photos.class.name == 'GalleryPhoto'
      _photos = photos.first.class.name == 'GalleryPhoto' ? photos : self.find(photos)

      Zip::ZipFile.open(arhive_dir + '.zip', Zip::ZipFile::CREATE) do |zipfile|
        _photos.each {|photo| zipfile.add("#{photo.id}#{File.extname(photo.photo_file_name)}", photo.photo.path(:big)) }
      end

      return arhive_dir + '.zip'

    end

  end

end
