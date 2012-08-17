class AddViewsCounterToPhotos < ActiveRecord::Migration
  def change
    add_column :gallery_photos, :views_counter, :integer, null: false, default: 0
  end
end
