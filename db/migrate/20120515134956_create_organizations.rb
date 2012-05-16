class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|

      t.timestamps
      t.string :title
      t.string :address
      t.integer :metro_station_id
    end
  end
end
