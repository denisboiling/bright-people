module ApplicationHelper
  # OPTIMIZE: brr
  def flash_messages
    html = ''
    [:notice, :error, :message, :success].map do |name|
      if flash[name]
        html += content_tag :div, flash[name], :class => name
      end
    end
    html.html_safe
  end
end
