class RemoveAgeTag < ActiveRecord::Migration
  def change
    remove_column :activities, :age
    drop_table :age_tags
  end
end
