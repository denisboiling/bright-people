class ArticlesController < ApplicationController
  def tag
    @article_tag_name = params[:id]
    @articles = Article.tagged_with(params[:id])
    render 'article_tags/show'
  end

  def index
    @categories = ArticleCategory.all
    @articles = Article.page(params[:page]).per(5)
  end

  def show
    @article = Article.find(params[:id])
    @tags = @article.tag_counts_on(:article_tags)
    @comments = @article.comments.top_level
  end
end
