def rand_point
  Point.from_x_y(55.755000 + "0.00#{rand(9999)}".to_f, 37.617000  + "0.00#{rand(9999)}".to_f, 4326)
end

FileUtils.rm_rf Rails.root.join('public/system/activities')

logos = Dir.glob(Rails.root.join('db/sample/files/activity_photos', '*'))

Activity.all.each do |ac|
  ac.recheck_approved
  ac.update_attribute(:location, rand_point)
  ac.update_attribute(:logo, File.new(logos.shuffle.first))
  if ac.is_edu?
    ac.direction_tags << DirectionTag.educational.sample(rand(3))
  else
    ac.direction_tags << DirectionTag.entertainment.sample(rand(3))
  end
end

#Activity.find_by_title("Main test education activity").update_attribute(:manager_id, 25)
