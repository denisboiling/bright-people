class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :title, :address
      t.integer :metro_station_id

      t.point :location, geographic: true, srid: 4326
      t.timestamps
    end
  end
end
