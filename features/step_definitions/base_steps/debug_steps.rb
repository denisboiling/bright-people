Then /^show me the page$/ do
  save_and_open_page
end

Given /^exec "(.*?)"$/ do |command|
  pp eval(command)
end
