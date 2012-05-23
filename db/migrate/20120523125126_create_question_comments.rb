class CreateQuestionComments < ActiveRecord::Migration
  def change
    create_table :question_comments do |t|
      t.integer :user_id, :quiestion_id, null: false
      t.text :text, null: false
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
     update "ALTER TABLE \"question_comments\" ADD \"path\" LTREE NOT NULL DEFAULT ''"
  end
end
