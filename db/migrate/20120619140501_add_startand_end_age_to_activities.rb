class AddStartandEndAgeToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.integer :start_age, :end_age, null: false, default: 0
    end
  end
end
