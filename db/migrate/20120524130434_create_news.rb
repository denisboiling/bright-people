class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      
      t.string :title
      t.text :content
      t.string :author
      t.has_attached_file :picture
      t.timestamps
    end
  end
end
