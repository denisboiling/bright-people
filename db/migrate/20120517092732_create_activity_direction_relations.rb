class CreateActivityDirectionRelations < ActiveRecord::Migration
  def change
    create_table :activity_direction_relations do |t|
      t.integer :activity_id
      t.integer :direction_tag_id
      
      t.timestamps
    end
  end
end
