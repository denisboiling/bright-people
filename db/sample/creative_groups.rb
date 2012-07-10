FileUtils.rm_rf Rails.root.join('public/system/creative_groups')

avatars = Dir.glob(Rails.root.join('db/sample/files/avatars', '*'))

CreativeGroup.all.each {|u| u.update_attribute(:avatar, File.new(avatars.shuffle.first))}
