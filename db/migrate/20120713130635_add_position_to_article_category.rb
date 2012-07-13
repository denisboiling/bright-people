class AddPositionToArticleCategory < ActiveRecord::Migration
  def change
    add_column :article_categories, :position, :integer, :null => false, :default => 0
  end
end
