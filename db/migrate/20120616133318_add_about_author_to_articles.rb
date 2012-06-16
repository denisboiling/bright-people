class AddAboutAuthorToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :biography, :text
  end
end
