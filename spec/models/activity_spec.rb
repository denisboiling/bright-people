require 'spec_helper'

describe Activity do
  it "Should be approved when expert approved" do
    activity = FactoryGirl.create(:activity)
    expert = FactoryGirl.create(:expert)
    activity.approved.should == false
    FactoryGirl.create(:activity_approval, activity: activity, expert: expert)
    activity.approved.should == true
  end
end
