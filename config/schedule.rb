every 10.minutes do
  rake "thinking_sphinx:index"
end

every :hour do
  rake "articles_posting"
  rake "news_posting"
end
