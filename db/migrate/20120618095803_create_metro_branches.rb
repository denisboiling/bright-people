class CreateMetroBranches < ActiveRecord::Migration
  def change
    create_table :metro_branches do |t|
      t.string :title
      t.has_attached_file :icon

      t.timestamps
    end
  end
end
