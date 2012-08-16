class GalleryPhoto < ActiveRecord::Base
  require 'zip/zip'

  FESTIVAL_START = Time.zone.parse('2012-08-18 10:00:00')

  include Rails.application.routes.url_helpers

  belongs_to :user

  has_attached_file :photo, styles: { thumb: ['240x240', :jpg], medium: ['1000x1000', :jpg], big: ['9999x9999>', :jpg] },
                            path: ":rails_root/public/system/gallery_photos/:attachment/:id/:style/:filename",
                            url: "/system/gallery_photos/:attachment/:id/:style/:filename",
                            default_style: :thumb,
                            default_url: 'loading.gif'

  attr_accessible :user_id, :photo, :views

  # validates :photo_fingerprint, presence: true, uniqueness: true
  validates :user, presence: true

  scope :published, where(processing: false)

  # Show photos filters by photograps and time
  scope :by_photograph_and_time, lambda{|user_ids, time|
    published.
    where('user_id IN (?) AND shot_date >= ?', user_ids, time)
  }

  # Show photos filters by time
  scope :by_time, lambda{|time| published.where('shot_date >= ?', time)}

  after_create :shot_date!

  # We can get date of shot only from TIFF(.NEF CR2) file.
  # For jpeg and png we sett current date timesmapt
  def shot_date!
    date = begin
             EXIFR::TIFF.new(self.photo.path(:original)).date_time
           rescue
             Time.zone.now
           end
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
    # TODO: remove this dirty hack about test env
    self.processing = true and return if Rails.env.test?
    self.processing ? false : true
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
    add_watermark
  end

  def add_watermark
    require 'RMagick'
    logo_path = Rails.root.join('public/logos/logo.png')
    styles = [:thumb, :medium, :big]
    styles.each do |style|
      pic_path = Rails.root.join('public'+photo.url(style, false))
      pic = Magick::Image.read(pic_path).first
      logo = Magick::Image.read(logo_path).first
      x_dim = pic.columns.to_i
      y_dim = pic.rows.to_i
      logo = logo.resize_to_fit(x_dim/4, y_dim/4)
      pic = pic.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)
      pic.write(pic_path)
    end
    return true
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
        _photos.each {|photo| zipfile.add("#{photo.id}.jpg", photo.photo.path(:big)) }
      end

      return arhive_dir + '.zip'

    end

  end

end
