class AddIsPostedFieldForArticlesAndNews < ActiveRecord::Migration
  def change
    add_column :articles, :is_posted, :boolean, null: false, default: false
    add_column :news, :is_posted, :boolean, null: false, default: false
  end
end
