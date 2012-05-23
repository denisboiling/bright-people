class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

      t.string :title
      t.text :content
      t.string :author
      t.integer :article_category_id
      t.has_attached_file :picture
      t.timestamps
    end
  end
end
