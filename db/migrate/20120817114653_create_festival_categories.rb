class CreateFestivalCategories < ActiveRecord::Migration
  def change
    create_table :festival_categories do |t|
      t.string :title
      t.timestamps
    end
    update "ALTER TABLE \"festival_categories\" ADD \"path\" LTREE NULL DEFAULT ''"
  end
end
