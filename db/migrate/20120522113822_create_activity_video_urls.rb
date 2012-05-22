class CreateActivityVideoUrls < ActiveRecord::Migration
  def change
    create_table :activity_video_urls do |t|
      t.text :url, null: false
      t.integer :activity_id, null: false
      t.timestamps
    end
  end
end
