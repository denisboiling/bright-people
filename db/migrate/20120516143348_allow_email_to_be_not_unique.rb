class AllowEmailToBeNotUnique < ActiveRecord::Migration
  def change
    remove_index :users, :email
    
    # create again but without :unique constraint
    add_index :users, :email
  end
end
