User.find_by_email('specialist@example.com').update_attributes(password: 'password', password_confirmation: 'password')
