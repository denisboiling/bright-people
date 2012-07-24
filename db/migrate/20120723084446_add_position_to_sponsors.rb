class AddPositionToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :position, :integer, null: false, default: 99
  end
end
