%w(user@example.com main_photographer@example.com photographer1@example.com).each do |email|
  User.find_by_email(email).update_attributes(password: 'password', password_confirmation: 'password')
end

FileUtils.rm_rf Rails.root.join('public/system/users')

avatars = Dir.glob(Rails.root.join('db/sample/files/avatars', '*'))

User.all.each {|u| u.update_attribute(:avatar, File.new(avatars.shuffle.first))}
