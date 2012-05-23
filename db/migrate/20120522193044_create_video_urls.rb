class CreateVideoUrls < ActiveRecord::Migration
  def change
    create_table :video_urls do |t|
      t.string :relation_type, null: false
      t.integer :relation_id, null: false
      t.text :url, null: false
      t.timestamps
    end
  end
end
