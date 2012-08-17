class AddFestivalCategoryIdToGalleryPhoto < ActiveRecord::Migration
  def change
    add_column :gallery_photos, :festival_category_id, :integer
  end
end
