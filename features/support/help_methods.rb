module HelpSteps
  def find_user(email)
    User.find_by_email(email)
  end

  def specialist_by_name(name)
    User.specialists.find_by_name(name)
  end
end

World(HelpSteps)
