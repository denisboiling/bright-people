AdminUser.all.each {|u| u.update_attributes(password: 'password', password_confirmation: 'password')}
