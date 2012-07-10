class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :category
      t.text :content
      t.has_attached_file :small_pic
      t.has_attached_file :large_pic

      t.timestamps
    end
  end
end
