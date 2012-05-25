class CreateActivityAgeRelations < ActiveRecord::Migration
  def change
    create_table :activity_age_relations do |t|
      t.integer :activity_id
      t.integer :age_tag_id
      
      t.timestamps
    end
  end
end
