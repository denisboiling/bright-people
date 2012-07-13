# -*- coding: utf-8 -*-
ActiveAdmin.register News do
  # TODO: reopen. quick fix
  #  scope_to :current_user, :association_method => :unscoped_news
  menu label: 'Новости фестиваля', :parent => "Фестиваль"

  filter :title

  index do
    id_column
    column "Фотография" do |news|
      link_to image_tag(news.photo.url(:thumb), alt: news.title), news.photo.url(:original)
    end
    column :title do |news|
      link_to news.title, news
    end
    column :content
    column :publication_date
    default_actions
  end

  form partial: "form"

  show do
    attributes_table :title, :content, :publication_date

    panel 'Фотография' do
      image_tag(news.photo.url(:original))
    end

  end
end
