class ArticlesController < ApplicationController
 def tag
    @article_tag_name = params[:id]
    @articles = Article.tagged_with(params[:id])
    render 'article_tags/show'
  end

  def index
    @articles = Article.all
    @categories = ArticleCategory.all
  end

  def show
    @article = Article.find(params[:id])
    @article_tags = @article.tag_counts_on(:article_tags)
    @article_comments = @article.article_comments.select(&:top_level?)
  end
end
