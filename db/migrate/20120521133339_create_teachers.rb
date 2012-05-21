class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|

      t.timestamps
      t.string :name
      t.text :description
      t.has_attached_file :photo
    end
  end
end
