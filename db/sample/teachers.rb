photos = Dir.glob(Rails.root.join('db/sample/files/teachers', '*'))

Teacher.all.each do |teacher|
  teacher.update_attribute(:photo, File.new(photos.shuffle.first))
  teacher.update_attribute(:activity_id,Activity.all.shuffle.first.id)
end
