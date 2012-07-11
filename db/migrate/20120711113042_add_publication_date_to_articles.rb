class AddPublicationDateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publication_date, :date
  end
end
