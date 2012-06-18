class AddMetroBranchIdToMetroStation < ActiveRecord::Migration
  def change
    add_column :metro_stations, :metro_branch_id, :integer
  end
end
