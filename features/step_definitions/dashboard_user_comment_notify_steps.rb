# OPTIMIZE: brrr... my stupid and lazy brain

# Given /^specialist answer for question "(.*?)"$/ do |question|
#   question = find_question(question)
#   comment = question.comments.build
#   comment.user = question.specialist
#   comment.text = 'zzzz'
#   comment.save
# end

# Given /^I create comment for question "(.*?)" with "(.*?)"$/ do |question, answer|
#   question = find_question(question)
#   comment = question.comments.build
#   comment.user = @user
#   comment.text = answer
#   comment.save
# end

# Then /^somebody commenting comment "(.*?)" with "(.*?)"$/ do |comment, text|
#   user = FactoryGirl.create(:user)
#   comment = find_comment(comment)
#   child_comment = user.comments.build
#   child_comment.relation = comment.relation
#   child_comment.relation_id = comment.relation_id
#   child_comment.text = text
#   child_comment.parent = comment
#   child_comment.save
# end
