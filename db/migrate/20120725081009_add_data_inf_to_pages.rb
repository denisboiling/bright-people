class AddDataInfToPages < ActiveRecord::Migration
  def change
    if Page.find_by_permalink('inf')
      puts "INFO!!! Page 'inf' already exist"
      return
    else
      page = Page.new
      page.permalink = 'inf'
      if page.save
        puts "INFO!!! Page 'inf' saved"
      else
        puts "ERROR!!! Something wrong, page 'inf' not saved"
      end
    end
  end
end
