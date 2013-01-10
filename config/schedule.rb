set :output, { :standard => nil }

every 10.minutes do
  rake "thinking_sphinx:index"
end
