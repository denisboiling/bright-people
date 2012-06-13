# -*- coding: utf-8 -*-
ActiveAdmin.register Article do

  filter :title
  filter :category
  filter :author

  index do
    id_column
    column "Фотография" do |article|
        link_to image_tag(article.picture.url(:thumb), alt: article.title), admin_article_path(article)
    end
    column :title
    column :author
    column :created_at
    column :updated_at
    default_actions
  end

  form :partial => "form"

  show do
    attributes_table :title, :author, :content, :short_description, :created_at, :updated_at, :picture, :article_category, :article_tag_list

    panel 'Фотография' do
     image_tag(article.picture.url)
    end
  end
end
