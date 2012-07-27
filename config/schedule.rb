every 10.minutes do
  rake "thinking_sphinx:index"
end

every :hour do
  rake "social_posting"
end
