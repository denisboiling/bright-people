class AddYearToStage < ActiveRecord::Migration
  def up
    add_column :stages, :year, :integer
    
    Stage.reset_column_information
    Stage.all.each do |stage|
      stage.update_attribute(:year, 2012)
      new_stage = stage.dup
      new_stage.year = 2013
      new_stage.save!
    end
  end
  
  def down
    remove_column :stages, :year
  end
end
