class NewsController < ApplicationController
  def tag
    @article_tag_name = params[:tag]
    @articles = Article.tagged_with(@article_tag_name)
    render 'article_tags/show'
  end


  def index
    if params[:remote]
      news = News.published.page(params[:page]).per(8)
      render partial: 'page', locals: { news: news }
    else
      @news = News.published.page(params[:page]).per(8)
    end
  end

  def show
    @news = News.published.find(params[:id])
    @tags = @news.tag_counts_on(:news_tags)
  end
end
