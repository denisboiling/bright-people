# encoding: utf-8

Given /^activities with fields:$/ do |table|
  table.hashes.each do |hash|
    activity = FactoryGirl.create(:activity, title: hash[:name])
    
    direction_names ||= []
    direction_names = eval(hash[:direction_tag_names]) if hash[:direction_tag_names]
    direction_names.each do |name|
      steps %{ Given direction tag with name "#{name}" }
      activity.direction_tags << DirectionTag.find_by_name(name)
    end
    
    age_tag_names ||= []
    age_tag_names = eval(hash[:age_tag_names]) if hash[:age_tag_names]
    age_tag_names.each do |name|
      match = /(\d+)-(\d+) лет/.match name
      start_year = match[1]
      end_year = match[2]
      steps %{ Given age tag with #{start_year} to #{end_year} interval }
      activity.age_tags << AgeTag.where(start_year: start_year, end_year: end_year).first
    end
  end
end
