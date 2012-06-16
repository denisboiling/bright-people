# encoding: utf-8

class ArticlesController < ApplicationController
  before_filter :load_object, only: :show
  before_filter :check_permission, only: :show

  def tag
    @article_tag_name = params[:id]
    @articles = Article.tagged_with(params[:id])
    render 'article_tags/show'
  end

  # OPTIMIZE: brrr
  def index
    @categories = ArticleCategory.all

    sort = params[:sort]
    sort ||= 'created_at'
    
    category = nil
    category = ArticleCategory.find(params[:category_id]) if params[:category_id]
    
    @articles = Article.published.order(sort)
    @articles = @articles.where(article_category_id: category.id) if category
    @articles = @articles.page(params[:page]).per(5)
    
    @persons_category = ArticleCategory.find_by_title("Личности")
    @teachers_category = ArticleCategory.find_by_title("Учителя")
    @foreign_category = ArticleCategory.find_by_title("Зарубежный опыт")
    @expert_category = ArticleCategory.find_by_title("Колонка эксперта")
    
    if category and params[:remote]
      render partial: 'page', locals: { articles: @articles, category: category }
    else
      @news_category = ArticleCategory.find_by_title("Новости")
      @best_articles = []
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
