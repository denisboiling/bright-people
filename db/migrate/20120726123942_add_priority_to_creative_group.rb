class AddPriorityToCreativeGroup < ActiveRecord::Migration
  def change
    add_column :creative_groups, :position, :integer, null: false, default: 0
  end
end
