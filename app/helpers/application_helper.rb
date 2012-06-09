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

  # OPTIMIZE: kill me for this... I'm sorry...
  def y_link(coords, title, *options)
    coords = coords.split(',')
    link_to (title + '<span></span>').html_safe, "http://maps.yandex.ru/?text=#{title}&ll=#{coords[1]},#{coords[0]}&spn=0.010986%2C0.003261&z=17&l=map", target: '_blank', class: 'to_map_link'
  end
end
