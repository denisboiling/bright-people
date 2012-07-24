class AddTextToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :text, :text
  end
end
