FileUtils.rm_rf Rails.root.join('public/system/activity_comments')

pictures = Dir.glob(Rails.root.join('db/sample/files/activity_comments', '*'))

ActivityComment.all.each do |comment|
  comment.update_attribute(:picture, File.new(pictures.shuffle.first))
end
