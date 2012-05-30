photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

Article.all.each do |article|
  article.update_attribute(:picture, File.new(photos.shuffle.first))
end
