# -*- coding: utf-8 -*-
ActiveAdmin.register News do
  menu label: 'Новости фестиваля', :parent => "Фестиваль"

  filter :title

  index do
    id_column
    column "Фотография" do |news|
        link_to image_tag(news.photo.url(:thumb), alt: news.title), admin_news_path(news)
    end
    column :title
    column :content
    column :created_at
    default_actions
  end

  form partial: "form"

  show do
    attributes_table :title, :content, :created_at

    panel 'Фотография' do
      image_tag(news.photo.url(:original))
    end

  end
end
