class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title, :address
      t.text :description
      t.integer :organization_id
      t.float :users_rating, :experts_rating, null: false, default: 0

      t.point :location, geographic: true, srid: 4326

      t.timestamps
    end
  end
end
