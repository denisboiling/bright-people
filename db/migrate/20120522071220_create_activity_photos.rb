class CreateActivityPhotos < ActiveRecord::Migration
  def change
    create_table :activity_photos do |t|
      t.has_attached_file :attach
      t.integer :activity_id
      t.timestamps
    end
  end
end
