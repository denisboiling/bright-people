class AddYearToCreativeGroups < ActiveRecord::Migration
  def up
    add_column :creative_groups, :year, :integer
    
    CreativeGroup.reset_column_information
    CreativeGroup.all.each do |group|
      group.update_attribute :year, 2012
      new_group = group.dup
      new_group.year = 2013
      new_group.save!
    end
  end
  
  def down
    remove_column :creative_groups, :year
  end
end
