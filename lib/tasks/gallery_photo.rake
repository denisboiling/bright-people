namespace :gallery_photo do
  desc "Arhive all photos by photograph id"
  # Execute like this: rake "gallery_photo:arhive[210698451]"
  task :arhive, [:id] => :environment do |t, args|
    photograph = User.junior_photographers.find(args.id)
    puts GalleryPhoto.create_archive(photograph.photo_ids, :original)
  end
end
