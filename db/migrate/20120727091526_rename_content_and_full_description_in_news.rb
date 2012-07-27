class RenameContentAndFullDescriptionInNews < ActiveRecord::Migration
  def change
    rename_column :news, :content, :short_description
    rename_column :news, :full_text, :content
  end
end
