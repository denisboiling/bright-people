user = User.first
['Activity', 'Organization', 'Article', 'Interview', 'News',
 'SpecialProject', 'Contest', 'ContestMembership'].each do |type|
  Favourite.create! user_id: user.id,
                    relation_id: type.constantize.first.id,
                    relation_type: type
end