class CreateDirectionTags < ActiveRecord::Migration
  def change
    create_table :direction_tags do |t|
      t.string :name
      t.boolean :is_educational
      
      t.timestamps
    end
  end
end
