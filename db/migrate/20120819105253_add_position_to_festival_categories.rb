class AddPositionToFestivalCategories < ActiveRecord::Migration
  def change
    add_column :festival_categories, :position, :integer, null: false, default: 99
  end
end
