FileUtils.rm_rf Rails.root.join('public/system/crew')

avatars = Dir.glob(Rails.root.join('db/sample/files/avatars', '*'))

Crew.all.each {|u| u.update_attribute(:photo, File.new(avatars.shuffle.first))}
