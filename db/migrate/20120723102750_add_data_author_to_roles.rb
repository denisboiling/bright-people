class AddDataAuthorToRoles < ActiveRecord::Migration
  # Add role 'author'
  def change
    if Role.find_by_name('author')
      puts "INFO!!! Role 'auhtor' already exist"
      return
    end
    role = Role.new
    role.id = 6
    role.name = 'author'
    if role.save
      puts "INFO!!! Role 'author' already created"
    else
      puts "ERROR!!! Role 'author' cant't be created"
    end
  end
end
