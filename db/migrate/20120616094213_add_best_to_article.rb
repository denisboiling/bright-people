class AddBestToArticle < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.boolean :published, null: false, default: false
    end
  end
end
