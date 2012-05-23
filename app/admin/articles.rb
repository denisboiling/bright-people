# -*- coding: utf-8 -*-
ActiveAdmin.register Article do
  menu label: 'Статьи'

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

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :content, input_html: {size: 10}
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:medium))
      f.input :article_category, as: :select, collection: ArticleCategory.all
      f.input :article_tag_list
    end
    f.buttons
  end

  show do
    attributes_table :title, :author, :content, :created_at, :updated_at, :picture, :article_category, :article_tag_list

    panel 'Фотография' do
#      image_tag(article.picture.url)
    end
  end
end
