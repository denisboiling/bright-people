class CreateAgeTags < ActiveRecord::Migration
  def change
    create_table :age_tags do |t|
      t.integer :start_year
      t.integer :end_year

      t.timestamps
    end
  end
end
