module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the specialists page$/
      specialists_path
    when /^the specialist "(.+)" page$/
      specialist_path(specialist_by_name($1))
    when /^the activities page$/
      activities_path
    when /^the article "(.+)" page$/
      article_path(article_by_title($1))
    when /^the interview "(.+)" page$/
      interview_path(interview_by_title($1))
    when /^the news "(.+)" page$/
      news_path(news_by_title($1))
    when /^the special_project "(.+)" page$/
      special_project_path(special_project_by_title($1))
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
