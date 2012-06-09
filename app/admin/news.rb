# -*- coding: utf-8 -*-
ActiveAdmin.register News do
  menu label: 'Новости'

  index do
    id_column
    column "Фотография" do |news|
        link_to image_tag(news.picture.url(:thumb), alt: news.title), admin_news_path(news)
    end
    column :title
    column :author
    column :created_at
    column :updated_at
    default_actions
  end

  form :partial => "form"

  show do
    attributes_table :title, :author, :content, :created_at, :updated_at, :picture, :news_tag_list

    panel 'Фотография' do
      image_tag(news.picture.url)
    end
  end
end
