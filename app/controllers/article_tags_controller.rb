class ArticleTagsController < ApplicationController
  def index
    @article_tags = Tag.find(:all)
  end

  def show
    @article_tag = Tag.find(params[:id])
    @articles = Article.find_tagged_with(@article_tag)
  end
end
