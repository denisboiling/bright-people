class AddDataRenewActivitiesRegionsWithCurrentMetroStations < ActiveRecord::Migration
  def change
    Activity.all.each do |activity|
      activity.region = activity.metro_stations.first.region if activity.metro_stations.present?
      activity.save!
    end
  end
end
