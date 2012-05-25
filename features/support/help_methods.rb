module HelpSteps
  def find_user(email)
    User.find_by_email(email)
  end

  def specialist_by_name(name)
    User.specialists.find_by_name(name)
  end

  def find_question(text)
    Question.find_by_text(text)
  end
end

World(HelpSteps)
