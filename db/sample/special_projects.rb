photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

SpecialProject.all.each do |specialproject|
  specialproject.update_attribute(:picture, File.new(photos.shuffle.first))
end
