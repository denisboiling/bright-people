Contest.all.each do |contest|
  category = ContestCategory.all.sample
  contest.category = category
  contest.save!
end