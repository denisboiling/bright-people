class RemoveAndAddDescriptionToCreativeGroups < ActiveRecord::Migration
  def change
    remove_column :creative_groups, :description
    add_column :creative_groups, :description, :text
  end
end
