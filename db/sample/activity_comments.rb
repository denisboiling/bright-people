FileUtils.rm_rf Rails.root.join('public/system/pictures')

pictures = Dir.glob(Rails.root.join('db/sample/files/activity_comments', '*'))

ActivityComment.all.each do |comment|
  comment.update_attributes(picture: File.new(pictures.shuffle.first), activity_id: Activity.all.shuffle.first.id)
end
