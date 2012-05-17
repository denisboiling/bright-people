Organization.all.each do |org|
  org.update_attribute(:location,
             Point.from_x_y(54.710000 + "0.00#{rand(9999)}".to_f, 20.500000  + "0.00#{rand(9999)}".to_f, 4326))
end
