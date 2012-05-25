Given /^a user visits article page$/ do
  @article = FactoryGirl.create(:article)
  visit article_path(@article)
end

Given /^a user visits interview page$/ do
  @interview = FactoryGirl.create(:interview)
  visit interview_path(@interview)
end

Given /^a user visits news page$/ do
  @news = FactoryGirl.create(:news)
  visit news_path(@news)
end

Given /^a user visits special_project page$/ do
  @special_project = FactoryGirl.create(:special_project)
  visit special_project_path(@special_project)
end

