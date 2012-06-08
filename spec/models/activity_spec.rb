require 'spec_helper'

describe Activity do
  it "Should be approved when user approved" do
    activity = FactoryGirl.create(:activity)
    user = FactoryGirl.create(:expert)
    activity.approved.should == false
    FactoryGirl.create(:activity_approval, activity: activity, user: user)
    activity.approved.should == true
  end
end
