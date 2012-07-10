FileUtils.rm_rf Rails.root.join('public/system/news')

photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

News.all.each do |news|
  news.update_attribute(:photo, File.new(photos.shuffle.first))
end

News.limit(5).each do |n|
  n.update_attribute(:publication_date, Time.now )
end
