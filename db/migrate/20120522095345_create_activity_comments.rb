class CreateActivityComments < ActiveRecord::Migration
  def change
    create_table :activity_comments do |t|

      t.timestamps
      t.string :commentator
      t.text :content
      t.has_attached_file :picture
      t.boolean :is_parent
      t.integer :activity_id
    end
  end
end
