FileUtils.rm_rf Rails.root.join('public/system/pictures')
pictures = Dir.glob(Rails.root.join('db/sample/files/contest_memberships', '*'))

Contest.all.each do |contest|
  category = ContestCategory.all.sample
  contest.category = category
  contest.save!
  
  rand(2..3).times do
    membership = ContestMembership.where(:contest_id => nil).first
    break unless membership
    
    membership.contest_id = contest.id
    membership.user_id = User.all.sample.id
    membership.picture = File.new(pictures.shuffle.first)
    membership.save!
  end
end