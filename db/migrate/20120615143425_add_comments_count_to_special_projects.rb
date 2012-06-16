class AddCommentsCountToSpecialProjects < ActiveRecord::Migration
  def change
    add_column :special_projects, :comments_count, :integer
  end
end
