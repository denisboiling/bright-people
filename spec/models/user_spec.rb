require 'spec_helper'

describe User do
  let (:user) {FactoryGirl.build(:user)}

  it "User should have user role when he created", current: true do
    user.save
    user.role.name.should == 'user'
  end
end
