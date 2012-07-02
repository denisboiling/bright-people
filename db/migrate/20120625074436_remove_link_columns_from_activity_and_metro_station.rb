class RemoveLinkColumnsFromActivityAndMetroStation < ActiveRecord::Migration
  def up
    change_table :activities do |t|
      t.remove :metro_station_id
    end
  end

  def down
    change_table :activities do |t|
      t.integer :metro_station_id
    end
  end
end
