# -*- coding: utf-8 -*-
ActiveAdmin.register Article do
  menu label: 'Статьи'

  scope :all, :default => true
  scope :published
  scope :not_published
  scope :bests

  filter :title
  filter :category
  filter :author

  index do
    id_column
    column "Фотография" do |article|
      link_to image_tag(article.picture, alt: article.title), article.picture.url(:original)
    end
    column :title do |article|
      link_to article.title, article
    end
    column :author
    column :created_at
    column :updated_at
    default_actions
  end

  form :partial => "form"

  show do
    attributes_table :title, :author, :created_at, :updated_at, :category, :article_tag_list, :published

    panel 'Посмотреть страницу' do
      link_to resource.title, resource, target: '_blank'
    end

    panel 'Краткое описание' do
      simple_format resource.short_description
    end

    panel 'Контент' do
      simple_format resource.content
    end

    panel 'Логотип' do
      image_tag(resource.picture.url(:original))
    end

  end
end
