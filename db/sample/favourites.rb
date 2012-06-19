%w(Activity Article SpecialProject Contest ContestMembership).each do |type|
  Favourite.create! user_id: 222,
  relation_id: type.constantize.first.id,
  relation_type: type
end
