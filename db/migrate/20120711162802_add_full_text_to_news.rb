class AddFullTextToNews < ActiveRecord::Migration
  def change
    add_column :news, :full_text, :text
  end
end
