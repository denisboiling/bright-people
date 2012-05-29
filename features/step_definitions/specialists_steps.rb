Given /^I am signup and signin as "(.+)" with "(.+)\/(.+)"$/ do |role, email, password|
  @user = FactoryGirl.create(role.to_sym, email: email, password: password)
  visit new_user_session_path
  find(:xpath, "id('new_user')").find_field('Email').set(email)
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end

Then /^question "(.*?)" should be publish$/ do |question|
  find_question(question).publish.should == true
end

Given /^specialist "(.*?)" create answer for question "(.*?)"$/ do |specialist, question|
  specialist = specialist_by_name(specialist)
  comment = Question.find_by_text(question).comments.build(text: 'this answer')
  comment.user = specialist
  comment.save
end
