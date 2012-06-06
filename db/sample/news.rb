FileUtils.rm_rf Rails.root.join('public/system/news')

photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

News.all.each do |news|
  users = Array.new
  (0..3).each do users << User.all.shuffle.first end
  news.update_attribute(:picture, File.new(photos.shuffle.first))
  news.update_attribute(:author_id, users.shuffle.first.id)
end
