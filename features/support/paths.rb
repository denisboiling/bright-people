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

      # Specialist dashboard
    when /^the specialist user question "(.+)" page$/
      specialist_user_question_path(find_question($1))

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
