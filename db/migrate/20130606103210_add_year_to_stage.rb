class AddYearToStage < ActiveRecord::Migration
  def up
    add_column :stages, :year, :integer
    
    Stage.reset_column_information
    Stage.all.each { |stage| stage.update_attribute(:year, 2012 ) }
  end
  
  def down
    remove_column :stages, :year
  end
end
