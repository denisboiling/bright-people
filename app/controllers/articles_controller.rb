class ArticlesController < ApplicationController
  def tag
    @article_tag_name = params[:id]
    @articles = Article.tagged_with(params[:id])
    render 'article_tags/show'
  end

  def index
    @categories = ArticleCategory.all
    
    categories_ids = (params[:categories_ids] or "").split(',').map(&:to_i)
    @articles = Article.scoped
    @articles = @articles.where(article_category_id: categories_ids) unless categories_ids.empty?
    @articles = @articles.page(params[:page]).per(5)
    render partial: 'articles_list', locals: { articles: @articles } if params[:remote]
  end

  def show
    @article = Article.find(params[:id])
    @tags = @article.tag_counts_on(:article_tags)
    @comments = @article.comments.top_level
  end
end
