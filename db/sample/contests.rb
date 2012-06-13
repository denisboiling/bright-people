FileUtils.rm_rf Rails.root.join('public/system/contests')

pictures = Dir.glob(Rails.root.join('db/sample/files/contest_memberships', '*'))
konkurs = Dir.glob(Rails.root.join('db/sample/files/konkurs', '*'))


Contest.all.each do |contest|
  contest.update_attribute(:picture, File.new(konkurs.shuffle.first))
  category = ContestCategory.all.sample
  contest.category = category
  contest.save!
end
