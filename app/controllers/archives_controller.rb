class ArchivesController < ApplicationController
  def show
    @author = Article.find(params[:article_id]).author
    @articles = @author.articles.page(params[:page]).per(5)
  end
end
