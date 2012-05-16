class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

      t.timestamps
      t.string :title
      t.text :description
      t.string :address
      t.string :metro_station
      t.integer :organization_id
      t.float :users_rating
      t.float :experts_rating
    end
  end
end
