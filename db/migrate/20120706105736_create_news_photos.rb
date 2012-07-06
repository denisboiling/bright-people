class CreateNewsPhotos < ActiveRecord::Migration
  def change
    create_table(:news_photos) do |t|
      t.string :attach_file_name, :attach_content_type
      t.integer :attach_file_size, :news_id
      t.datetime :attach_updated_at

      t.timestamps
    end
  end
end
