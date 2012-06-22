# -*- coding: utf-8 -*-
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
    unless coords.blank?
      coords = coords.split(',')
      link_to (title + '<span></span>').html_safe, "http://maps.yandex.ru/?text=#{title}&ll=#{coords[1]},#{coords[0]}&spn=0.010986%2C0.003261&z=17&l=map", target: '_blank', class: 'to_map_link'
    else
      link_to (title + '<span></span>').html_safe, "http://maps.yandex.ru/?text=#{title}&spn=0.010986%2C0.003261&z=16&l=map", target: '_blank', class: 'to_map_link'
    end
  end

  # This need for /activities search form
  # OPTIMIZE:
  def search_ages
    [['до года', '0-0']] | [1, 4, 7, 10].map{|i| ["#{i}—#{i+2} лет", "#{i}-#{i+2}"]} | [['13—16 лет', '13-16']]
  end
end
