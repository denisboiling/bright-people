# -*- coding: utf-8 -*-
module ApplicationHelper
  # OPTIMIZE: brr
  def flash_messages
    html = ''
    [:notice, :error, :message, :success].map do |name|
      if flash[name]
        html += content_tag :div, ( content_tag :span, flash[name] ), :class => name.to_s + ' notify'
      end
    end
    html.html_safe
  end

  # OPTIMIZE: kill me for this... I'm sorry...
  def y_link(coords, title, *options)
    unless coords.blank?
      coords = coords.split(',')
      link_to ('<span></span>' + title ).html_safe, "http://maps.yandex.ru/?text=#{title}&ll=#{coords[1]},#{coords[0]}&spn=0.010986%2C0.003261&z=17&l=map", target: '_blank', class: 'to_map_link'
    else
      link_to ( '<span></span>' + title ).html_safe, "http://maps.yandex.ru/?text=#{title}&spn=0.010986%2C0.003261&z=16&l=map", target: '_blank', class: 'to_map_link'
    end
  end

  # This need for /activities search form
  # OPTIMIZE:
  def search_ages
    [['до года', '0-0']] | [1, 4, 7, 10].map{|i| ["#{i}—#{i+2} лет", "#{i}-#{i+2}"]} | [['13—16 лет', '13-16']]
  end

  def age_collection(type, start_age=0, end_age=16)
    word = type == :start ? 'от ' : 'до '
    (0..16).map {|a| [ word + I18n.t(:age, count: a), a]}
  end

  def include_js(position,*js)
    content_for(position) do
      js.map{|_js| javascript_include_tag(_js)}.join("\n").html_safe
    end
  end

  # Load yandex map js files
  def load_ymaps(full=false)
    (full ? '//api-maps.yandex.ru/2.0/?load=package.full&lang=ru-RU' :
      '//api-maps.yandex.ru/2.0/?load=package.standard&lang=ru-RU') unless block_external_js?
  end

  # If we don't want to load external js like lokar or ympas we start
  # rails server by following command:
  # BLOCK_EXT_JS=true rails s
  def block_external_js?
    true if ENV['BLOCK_EXT_JS']
  end

  # Show time with russian words
  def r_time(time, format=:article)
    _format = case format
              when :article then '%e %B, %A'
              else
                '%e %B, %A'
              end
    Russian::strftime(time, _format)
  end

  def image_full_url(img_path)
    return img_path unless ActionController::Base.asset_host
    File.join(ActionController::Base.asset_host, img_path)
  end
end
