Given /^direction tag with name "(.*?)"$/ do |name|
  FactoryGirl.create(:direction_tag, name: name) unless DirectionTag.find_by_name(name)
end
