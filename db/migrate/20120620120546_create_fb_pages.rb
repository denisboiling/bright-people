class CreateFbPages < ActiveRecord::Migration
  def change
    create_table :fb_pages do |t|
      t.integer :identifier, :limit => 8
      t.string :token
      t.timestamps
    end
  end
end
