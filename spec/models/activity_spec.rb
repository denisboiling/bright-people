require 'spec_helper'

describe Activity do
  it "Should be approved when expert approved" do
    activity = FactoryGirl.create(:activity)
    user = FactoryGirl.create(:expert)
    activity.approved.should == false
    FactoryGirl.create(:activity_approval, activity: activity, user: user)
    activity.approved.should == true
  end

  # it "Should check nice approval", current: true do
  #   10.times.each { FactoryGirl.create(:activity, approved: true) }
  #   5.times.each { FactoryGirl.create(:activity, approved: false) }
  #   activities = Activity.nice_approval(Activity.all)
  #   puts activities.map {|a| [a.id, a.approved]}
  #   activities[4].approved?.should == false
  #   activities[4].approved?.should == false
  # end
end
