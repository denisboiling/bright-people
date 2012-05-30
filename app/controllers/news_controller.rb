class NewsController < ApplicationController
  def tag
    @news_tag_name = params[:id]
    @news = News.tagged_with(params[:id])
    render 'news_tags/show'
  end

  def index
    @news = News.all
  end

  def show
    @news = News.find(params[:id])
    @tags = @news.tag_counts_on(:news_tags)
    @comments = @news.comments.top_level
  end
end
