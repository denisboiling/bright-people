FileUtils.rm_rf Rails.root.join('public/system/news')

photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

News.all.each do |news|
  news.update_attribute(:photo, File.new(photos.shuffle.first))
end
