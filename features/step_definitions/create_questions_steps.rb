Given /^I am signin and login as "(.+)" with "(.+)\/(.+)"$/ do |role, email, password|
  if role == 'user'
    @user = FactoryGirl.create(:user, email: email, password: password)
  else
    @user = FactoryGirl.create(role.to_sym, email: email, password: password)
  end
end
