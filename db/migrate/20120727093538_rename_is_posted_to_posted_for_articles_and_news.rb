class RenameIsPostedToPostedForArticlesAndNews < ActiveRecord::Migration
  def change
    rename_column :news, :is_posted, :posted
    rename_column :articles, :is_posted, :posted
  end
end
