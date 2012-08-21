class AddLandscapeToGalleryPhotos < ActiveRecord::Migration
  def change
    add_column :gallery_photos, :landscape, :boolean
  end
end
