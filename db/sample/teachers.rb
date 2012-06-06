FileUtils.rm_rf Rails.root.join('public/system/teachers')

photos = Dir.glob(Rails.root.join('db/sample/files/teachers', '*'))

Teacher.all.each do |teacher|
  teacher.update_attribute(:photo, File.new(photos.shuffle.first))
end
