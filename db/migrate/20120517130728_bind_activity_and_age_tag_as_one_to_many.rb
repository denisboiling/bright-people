class BindActivityAndAgeTagAsOneToMany < ActiveRecord::Migration
  def change
    add_column :activities, :age_tag_id, :integer
  end
end
