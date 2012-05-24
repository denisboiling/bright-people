class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      
      t.string :title
      t.text :content
      t.string :author
      t.has_attached_file :picture
      t.timestamps
    end
  end
end
