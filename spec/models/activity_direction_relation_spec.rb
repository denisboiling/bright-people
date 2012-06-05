# -*- coding: utf-8 -*-
require 'spec_helper'

describe ActivityDirectionRelation do
  it "Create age for activity" do
    activity = FactoryGirl.create(:activity)
    a_13 = FactoryGirl.create(:age_tag, start_year: 1, end_year: 3)
    a_69 = FactoryGirl.create(:age_tag, start_year: 6, end_year: 9)
    activity.age_tags << a_13
    activity.age_tags << a_69
    Activity.find(activity).age.should == "1 — 9"
  end
end
