class CreateMetroStations < ActiveRecord::Migration
  def change
    create_table :metro_stations do |t|

      t.timestamps
      t.string :title
    end
  end
end
