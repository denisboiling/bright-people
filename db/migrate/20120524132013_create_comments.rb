class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :interview_id
      t.integer :article_id

      t.timestamps
    end
    update "ALTER TABLE \"comments\" ADD \"path\" LTREE NULL DEFAULT ''"
  end
end
