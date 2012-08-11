FileUtils.rm_rf Rails.root.join('public/system/gallery_photos')
FileUtils.rm_rf Rails.root.join('public/arhives')

photos = Dir.glob(Rails.root.join('db/sample/files/*/', '*.jpg'))

30.times.each do |i|
  GalleryPhoto.create(user_id: rand(26..30),
                      photo: File.new(photos.shift))
end
