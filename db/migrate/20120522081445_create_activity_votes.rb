class CreateActivityVotes < ActiveRecord::Migration
  def change
    create_table :activity_votes do |t|
      t.integer :activity_id
      t.integer :user_id
      t.integer :rate
      
      t.timestamps
    end
  end
end
