photos = Dir.glob(Rails.root.join('db/sample/files/activity_photos', '*'))

ActivityPhoto.all.each {|a| a.update_attribute(:attach, File.new(photos.shuffle.first))}