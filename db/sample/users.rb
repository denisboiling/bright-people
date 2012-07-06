User.find_by_email('user@example.com').update_attributes(password: 'password', password_confirmation: 'password')
User.find_by_email('moder@example.com').update_attributes(password: 'password', password_confirmation: 'password')

FileUtils.rm_rf Rails.root.join('public/system/users')

avatars = Dir.glob(Rails.root.join('db/sample/files/avatars', '*'))

User.all.each {|u| u.update_attribute(:avatar, File.new(avatars.shuffle.first))}
