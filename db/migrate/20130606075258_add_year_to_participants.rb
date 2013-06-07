class AddYearToParticipants < ActiveRecord::Migration
  def up
    add_column :participants, :year, :integer
    
    Participant.reset_column_information
    Participant.all.each do |p|
      p.update_attribute(:year, 2012)
      new_p = p.dup
      new_p.year = 2013
      new_p.save(:validate => false)
    end
  end
  
  def down
    remove_column :participants, :year
  end
end
