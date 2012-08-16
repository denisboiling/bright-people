# Add photographers roles
class AddDataAddPhotographersRoles < ActiveRecord::Migration
  def change
    unless Role.find_by_name('photographer')
      if Role.create(id: 7, name: 'photographer')
        puts "INFO!!! role 'photographer' was created"
      else
        puts "ERROR!!! role 'photographer' was not created"
      end
    end

    unless Role.find_by_name('main_photographer')
      if Role.create(id: 8, name: 'main_photographer')
        puts "INFO!!! role 'main_photographer' was created"
      else
        puts "ERROR!!! role 'main_photographer' was not created"
      end
    end
  end
end
