class AddPostionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :position, :integer, null: false, default: 99
  end
end
