FileUtils.rm_rf Rails.root.join('public/system/articles')

photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

Article.all.each do |article|
  users = Array.new
  (0..3).each do users << User.all.shuffle.first end
  article.update_attribute(:picture, File.new(photos.shuffle.first))
  article.update_attribute(:author_id, users.shuffle.first.id)
end
