class AddDataAddManagerRole < ActiveRecord::Migration
  def change
    if Role.find_by_name('manager').present?
      puts "Role manager already exists"
    else
      role = Role.new
      role.id = 5
      role.name = 'manager'
      if role.save
        puts "Role 'manager' is created"
      else
        puts "ERROR!!! I can't create role 'manager'"
      end
    end
  end
end
