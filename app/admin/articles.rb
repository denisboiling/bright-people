# -*- coding: utf-8 -*-
ActiveAdmin.register Article, :as => "ArticlePost" do
  menu label: 'Статьи'

  scope :all, :default => true
  scope :published
  scope :not_published

  filter :title
  filter :category
  filter :author

  index do
    id_column
    column "Фотография" do |article|
        link_to image_tag(article.picture.url(:thumb), alt: article.title), admin_article_post_path(article)
    end
    column :title
    column :author
    column :created_at
    column :updated_at
    default_actions
  end

  # controller do
  #   def new
  #     new! do |format|
  #       format.html { render :partial => 'admin/article_posts/new'  }
  #     end
  #   end
  #   def edit
  #     new! do |format|
  #       format.html { render :partial => 'admin/article_posts/edit'  }
  #     end
  #   end
  # end

  form :partial => "form"

  show do
    attributes_table :title, :author, :created_at, :updated_at, :category, :article_tag_list

    panel 'Посмотреть страницу' do
      link_to article_post.title, article_path(article_post), target: '_blank'
    end

    panel 'Краткое описание' do
      simple_format article_post.short_description
    end

    panel 'Контент' do
      simple_format article_post.content
    end

    panel 'Логотип' do
      image_tag(article_post.picture.url(:original))
    end

  end
end
