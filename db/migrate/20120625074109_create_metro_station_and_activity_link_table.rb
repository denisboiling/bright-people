class CreateMetroStationAndActivityLinkTable < ActiveRecord::Migration
  def up
    create_table :activities_metro_stations, :id => false do |t|
        t.references :activity
        t.references :metro_station
    end
  end

  def down
    drop_table :activities_metro_stations
  end
end
