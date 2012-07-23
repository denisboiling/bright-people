require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  it "User should have user role when he created" do
    user.role.name.should == 'user'
  end

  it "User must become author when he write a his first post" do
    FactoryGirl.create(:article, author: user)
    user.role.name.should == 'author'
  end
end
