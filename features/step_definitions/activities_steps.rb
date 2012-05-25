Given /^activities with fields:$/ do |table|
  table.hashes.each do |hash|
    direction_names =
      if hash[:direction_tag_names]
        eval(hash[:direction_tag_names])
      else
        []
      end
    
    activity = FactoryGirl.create(:activity, title: hash[:name])
    direction_names.each do |name|
      steps %{
        Given direction tag with name "#{ name }"
      }
      activity.direction_tags << DirectionTag.find_by_name(name)
    end
  end
end
