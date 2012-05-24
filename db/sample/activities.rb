Activity.all.each do |ac|
  ac.update_attribute :location, Point.from_x_y(54.710000 + "0.00#{rand(9999)}".to_f,
                                                20.500000  + "0.00#{rand(9999)}".to_f, 4326)
  rand(1..3).times do
    tag =
      if ac.is_educational
        DirectionTag.educational.sample
      else
        DirectionTag.entertainment.sample
      end
    ac.direction_tags << tag
  end
  
  rand(1..3).times do
    tag = AgeTag.all.sample
    ac.age_tags << tag
  end
end
