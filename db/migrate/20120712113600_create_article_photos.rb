class CreateArticlePhotos < ActiveRecord::Migration
  def change
    create_table :article_photos do |t|
      t.integer :article_id
      t.has_attached_file :attach

      t.timestamps
    end
  end
end
