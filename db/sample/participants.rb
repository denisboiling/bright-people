logos = Dir.glob(Rails.root.join('db/sample/files/activity_photos', '*'))

Participant.all.each do |p|
  p.update_attribute(:logo, File.new(logos.shuffle.first))
end
