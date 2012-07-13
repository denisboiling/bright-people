# -*- coding: utf-8 -*-
class ArticlesController < ApplicationController
  before_filter :load_object, only: :show
  before_filter :check_permission, only: :show

  def tag
    @article_tag_name = params[:tag]
    @articles = Article.tagged_with(@article_tag_name)
    render 'article_tags/show'
  end

  # OPTIMIZE: brrr
  # TODO: :shit:
  def index
    @article_page = true
    category = nil
    category = ArticleCategory.find(params[:category_id]) if params[:category_id]

    @persons_category = ArticleCategory.find_by_title("Личности")
    @foreign_category = ArticleCategory.find_by_title("Зарубежный опыт")
    @expert_category = ArticleCategory.find_by_title("Колонка эксперта")

    if category and params[:remote]
      @articles = Article.published.order('created_at DESC')
      @articles = @articles.where(article_category_id: category.id) if category
      @articles = @articles.page(params[:page]).per(5)

      render partial: 'page', locals: { articles: @articles, category: category }
    else
      @best_articles = Article.where(best: true)
        .order('created_at DESC')
        .first(3)
    end
  end

  def show
    @tags = @article.tag_counts_on(:article_tags)
    @comments = @article.comments.top_level
  end

  private

  def check_permission
    return if current_admin_user
    redirect_to root_path unless @article.published?
  end

  def load_object
    @article = Article.find(params[:id])
  end
end
