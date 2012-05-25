photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

Interview.all.each do |interview|
  interview.update_attribute(:picture, File.new(photos.shuffle.first))
end
