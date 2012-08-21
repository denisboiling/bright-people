FileUtils.rm_rf Rails.root.join('public/system/gallery_photos')
FileUtils.rm_rf Rails.root.join('public/arhives')

photos = Dir.glob(Rails.root.join('db/sample/files/*/', '*.jpg'))

300.times.each do |i|
  GalleryPhoto.create(user_id: User.junior_photographers.sample.id,
                      photo: File.new(photos.sample),
                      views: rand(1..9999))
end
