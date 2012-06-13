article = Article.first
user1 = User.first
user2 = User.last

comment1 = article.comments.build
comment1.text = 'one'
comment1.user_id = user1.id
comment1.save!

comment2 = article.comments.build
comment2.text = 'two'
comment2.user_id = user2.id
comment2.parent = comment1
comment2.save!