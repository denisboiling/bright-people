class AddPriorityToCreativeGroup < ActiveRecord::Migration
  def change
    add_column :creative_groups, :priority, :integer, :default => 0
  end
end
