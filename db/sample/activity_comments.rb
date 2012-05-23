pictures = Dir.glob(Rails.root.join('db/sample/files/activity_comments', '*'))

ActivityComment.all.each do |comment|
  comment.update_attributes(picture: File.new(pictures.shuffle.first), activity: Activity.all.shuffle.first)
end
