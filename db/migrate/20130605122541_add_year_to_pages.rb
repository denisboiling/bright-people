class AddYearToPages < ActiveRecord::Migration
  def up
    add_column :pages, :year, :integer
    
    Page.reset_column_information
    Page.all.each do |page|
      page.update_attribute :year, 2012
      new_page = page.dup
      new_page.year = 2013
      new_page.save!
    end
  end
  
  def down
    remove_column :pages, :year
  end
end
