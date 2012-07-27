class AddIsPostedFieldForArticlesAndNews < ActiveRecord::Migration
  def change
    add_column :articles, :posted, :boolean, null: false, default: false
    add_column :news, :posted, :boolean, null: false, default: false
  end
end
