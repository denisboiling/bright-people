class AddYearToCreativeGroups < ActiveRecord::Migration
  def up
    add_column :creative_groups, :year, :integer
    
    CreativeGroup.reset_column_information
    CreativeGroup.all.each { |group| group.update_attributes!(year: 2012 ) }
  end
  
  def down
    remove_column :creative_groups, :year
  end
end
