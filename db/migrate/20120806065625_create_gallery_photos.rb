class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.integer :user_id, null: false
      t.attachment :photo
      t.string :photo_fingerprint
      t.datetime :shot_date
      t.boolean :processing, null: false, default: true
      t.integer :views, null: false, default: 0
      t.timestamps
    end
  end
end
