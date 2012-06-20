namespace :fixes do
  task :fix_age_tags => :environment do
    Activity.all.each do |activity|
      next unless activity.age_tags.present?
      ages = activity.age_tags.map {|a| [a.start_year, a.end_year]}.flatten.uniq
      start_age = ages.min
      end_age = ages.max
      activity.start_age = start_age || 0
      activity.end_age = end_age || 0
      activity.save
    end
  end
end
