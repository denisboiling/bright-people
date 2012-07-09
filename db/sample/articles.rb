FileUtils.rm_rf Rails.root.join('public/system/articles')

photos = Dir.glob(Rails.root.join('db/sample/files/articles', '*'))

Article.all.each do |article|
  users = Array.new
  (0..3).each do users << User.all.shuffle.first end
  article.update_attribute(:picture, File.new(photos.shuffle.first))
  article.update_attribute(:author_id, users.shuffle.first.id)
end

arr = Array.new

arr = Article.all.pop(3)
arr.each do |a|
  a.best = true
  a.save!
end

a = Article.find(1)
a.article_tag_list=%w"tag1 tag2 tag3"
a.save

a = Article.find(2)
a.article_tag_list=%w"tag1 tag2"
a.save

a = Article.find(3)
a.article_tag_list=%w"tag3"
a.save

a = Article.find(4)
a.article_tag_list=%w"tag2 tag3"
a.save

