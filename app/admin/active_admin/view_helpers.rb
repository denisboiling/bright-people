# -*- coding: utf-8 -*-
module ActiveAdmin::ViewHelpers
  def age_collection(type, start_age=0, end_age=16)
    word = type == :start ? 'от ' : 'до '
    (0..16).map {|a| [ word + I18n.t(:age, count: a), a]}
  end

  # TODO: replace!!!!
  def all_stages
    [
      ['Музыкальная сцена', 'music_stage' ],
      ['Театральная сцена', 'theater_stage'],
      ['Цирковая сцена', 'circus_stage'],
      ['Уличные театры', 'street_theater'],
      ['Мастер-классы', 'master_class']
    ]
  end

  def user_vk_link(user)
    return user.name unless vk_id = user.vkontakte_id
    [user.name, link_to('VK', "http://vk.com/id#{vk_id}")].join(' ').html_safe
  end

  # Generate inputs with image urls by each styles
  def images_form(picture)
    [:thumb, :medium, :original].map do |style|
      label_tag(nil, I18n.t('picture.' + style.to_s)) +
        text_field_tag(nil, 'http://images.bright-people.ru' + picture.picture.url(style, timestamp: false), size: 45)
    end.join("<br>").html_safe
  end

  # Generate 24 chars password
  def rand_password
    24.times.map{ ('a'..'z').to_a[rand(26)] }.join
  end
end
