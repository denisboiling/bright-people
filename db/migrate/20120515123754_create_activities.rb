class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

      t.timestamps
      t.string :title
      t.text :description
      t.string :address
      t.integer :metro_station_id
      t.integer :organization_id
      t.float :users_rating
      t.float :experts_rating
      t.boolean :is_educational
    end
  end
end
