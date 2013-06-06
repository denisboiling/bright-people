class AddYearToParticipants < ActiveRecord::Migration
  def up
    add_column :participants, :year, :integer
    
    Participant.reset_column_information
    Participant.all.each { |p| p.update_attribute(:year, 2012 ) }
  end
  
  def down
    remove_column :participants, :year
  end
end
