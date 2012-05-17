class CreateExperts < ActiveRecord::Migration
  def change
    create_table :experts do |t|
      t.string :name
      t.text :description
      t.has_attached_file :photo
      t.timestamps
    end
  end
end
