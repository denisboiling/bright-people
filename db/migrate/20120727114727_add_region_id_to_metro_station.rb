class AddRegionIdToMetroStation < ActiveRecord::Migration
  def change
    add_column :metro_stations, :region_id, :integer
  end
end
