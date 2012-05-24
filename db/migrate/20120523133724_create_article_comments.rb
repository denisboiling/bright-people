class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|

      t.string :author
      t.text :content
      t.integer :article_id
      t.timestamps
    end
    update "ALTER TABLE \"article_comments\" ADD \"path\" LTREE NULL DEFAULT ''"
  end
end
