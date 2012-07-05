class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.has_attached_file :photo

      t.timestamps
    end
  end
end
