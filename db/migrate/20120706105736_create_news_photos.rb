class CreateNewsPhotos < ActiveRecord::Migration
  def change
    create_table(:news_photos) do |t|
      t.integer :news_id
      t.has_attached_file :attach

      t.timestamps
    end
  end
end
