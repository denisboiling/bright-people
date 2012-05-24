class CreateInterviewComments < ActiveRecord::Migration
  def change
    create_table :interview_comments do |t|

      t.string :author
      t.text :content
      t.integer :interview_id

      t.timestamps
    end
    update "ALTER TABLE \"interview_comments\" ADD \"path\" LTREE NULL DEFAULT ''"
  end
end
