class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title, :address
      t.text :description

      t.integer :organization_id
      t.float :users_rating, :experts_rating, null: false, default: 0

      t.point :location, geographic: true, srid: 4326
      t.integer :metro_station_id
      t.boolean :is_educational
      t.timestamps

      t.text :parent_activities
      t.text :additional_information
    end
  end
end
