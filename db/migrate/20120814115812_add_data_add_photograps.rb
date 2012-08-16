# -*- coding: utf-8 -*-
# Add default 10 joniuor photographers. 10 is a magic number
class AddDataAddPhotograps < ActiveRecord::Migration
  def change
    puts "Add junior photographers"
    [
      {position: 1, name: 'Михаил Потапов'},
      {position: 2, name: 'Михаил Потапов'},
      {position: 3, name: 'Михаил Потапов'},
      {position: 4, name: 'Михаил Потапов'},
      {position: 5, name: 'Михаил Потапов'},
      {position: 6, name: 'Михаил Потапов'},
      {position: 7, name: 'Михаил Потапов'},
      {position: 8, name: 'Михаил Потапов'},
      {position: 9, name: 'Михаил Потапов'},
      {position: 10, name: 'Михаил Потапов'},
    ].each do |photographer|
      user = User.new(photographer)
      user.role_id = 7
      user.email = "photographer#{photographer[:position]}@example.com"
      user.password = 24.times.map{ ('a'..'z').to_a[rand(26)] }.join
      user.save
    end
  end
end
