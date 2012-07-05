class AddManagerToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :manager_id, :integer
  end
end
