# TODO: hell
namespace :quick do
  task :load_photos => :environment do
    load Rails.root.join('db/sample/gallery_photos.rb')
  end
end
