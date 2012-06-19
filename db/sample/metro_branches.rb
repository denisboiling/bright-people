FileUtils.rm_rf Rails.root.join('public/system/metro_branches')

photos = Dir.glob(Rails.root.join('db/sample/files/metro_branches', '*'))

MetroBranch.all.each do |b|
  b.update_attribute(:icon, File.new(photos.shuffle.first))
end
