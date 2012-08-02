pictures = Dir.glob(Rails.root.join('db/sample/files/contest_memberships', '*'))

ContestMembership.all.each do |membership|
    membership = ContestMembership.where(:contest_id => nil).first
    break unless membership

    membership.contest_id = Contest.all.shuffle.first.id
    membership.user_id = User.all.sample.id
    membership.picture = File.new(pictures.shuffle.first)
    membership.save!
end
