class AddShortDescriptionToSpecialProjects < ActiveRecord::Migration
  def change
    add_column :special_projects, :short_description, :text
  end
end
