AdminUser.find_by_email('admin@example.com').update_attributes(password: 'password', password_confirmation: 'password')
AdminUser.find_by_email('editor@example.com').update_attributes(password: 'password', password_confirmation: 'password')
