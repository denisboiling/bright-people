class RemoveManagerIdFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :manager_id
  end
end
