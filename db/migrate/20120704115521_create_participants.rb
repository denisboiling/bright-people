class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :title
      t.text :description
      t.has_attached_file :logo
      t.boolean :headliner, null: false, default: false

      t.timestamps
    end
  end
end
