class AddBestToArticle < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.boolean :best, default: false, null: false
    end
  end
end
