class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :title
      t.text :description
      t.has_attached_file :logo
      t.boolean :headliner, null: false, default: false
      t.integer :priority, null: 1, default: 1
      t.string :category

      t.timestamps
    end
  end
end
