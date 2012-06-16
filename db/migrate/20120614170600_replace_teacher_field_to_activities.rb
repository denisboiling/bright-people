class ReplaceTeacherFieldToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.text :replace_teacher_text
      t.boolean :published, null: false, default: false
    end
  end

end
