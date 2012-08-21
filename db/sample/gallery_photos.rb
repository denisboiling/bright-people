FileUtils.rm_rf Rails.root.join('public/system/gallery_photos')
FileUtils.rm_rf Rails.root.join('public/arhives')

photos = Dir.glob(Rails.root.join('db/sample/files/*/', '*.jpg'))

photos_count = ENV['PHOTOS_COUNT'].present? ? ENV['PHOTOS_COUNT'].to_i : 300

photographer = User.find_by_email('photographer1@example.com')

photos_count.times.each do |i|
  GalleryPhoto.create(user_id: [photographer.id, User.junior_photographers.sample.id].sample,
                      photo: File.new(photos.sample),
                      views: rand(1..9999))
end
