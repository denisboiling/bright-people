class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|

      t.timestamps
      t.string :title
      t.string :address
      t.string :metro_station
    end
  end
end
