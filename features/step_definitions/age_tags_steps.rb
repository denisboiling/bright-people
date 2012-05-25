Given /^age tag with (\d+) to (\d+) interval$/ do |start_year, end_year|
  FactoryGirl.create(:age_tag, start_year: start_year, end_year: end_year)
end
