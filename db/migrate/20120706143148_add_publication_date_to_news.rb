class AddPublicationDateToNews < ActiveRecord::Migration
  def change
    add_column :news, :publication_date, :date
  end
end
