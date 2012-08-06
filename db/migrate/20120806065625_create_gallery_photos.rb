class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.integer :user_id, null: false
      t.attachment :photo
      t.timestamps
    end
  end
end
