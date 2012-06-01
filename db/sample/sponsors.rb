FileUtils.rm_rf Rails.root.join('public/system/sponsors')

photos = Dir.glob(Rails.root.join('db/sample/files/sponsors', '*'))

Sponsor.all.each {|u| u.update_attribute(:photo, File.new(photos.shuffle.first))}
