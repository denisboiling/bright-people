class AddYearToPages < ActiveRecord::Migration
  def up
    add_column :pages, :year, :integer
    
    Page.reset_column_information
    Page.all.each { |page| page.update_attributes!(year: 2012 ) }
  end
  
  def down
    remove_column :pages, :year
  end
end
