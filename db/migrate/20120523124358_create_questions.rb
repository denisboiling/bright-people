class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :specialist_id, :user_id, null: false
      t.text :text, null: false
      t.boolean :publish, null: false, default: false
      t.timestamps
    end
  end
end
