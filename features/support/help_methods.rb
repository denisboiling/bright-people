module HelpSteps
  def find_user(email)
    User.find_by_email(email)
  end

  def article_by_title(title)
    Article.find_by_title(title)
  end

  def interview_by_title(title)
    Interview.find_by_title(title)
  end

  def special_project_by_title(title)
    SpecialProject.find_by_title(title)
  end

  def news_by_title(title)
    News.find_by_title(title)
  end

  def find_comment(text)
    Comment.find_by_text(text)
  end
end

World(HelpSteps)
