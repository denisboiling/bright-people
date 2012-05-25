Given /^I am signin and login as "(.+)" with "(.+)\/(.+)"$/ do |role, email, password|
  @user = FactoryGirl.create(role.to_sym, email: email, password: password)
  visit new_user_session_path
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end
