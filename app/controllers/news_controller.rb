class NewsController < ApplicationController
  def tag
    @article_tag_name = params[:tag]
    @articles = Article.tagged_with(@article_tag_name)
    render 'article_tags/show'
  end


  def index
    if params[:remote]
      @news = Kaminari.paginate_array(News.published).page(params[:page]).per(8)
      render partial: 'page', locals: { news: @news }
    else
      @news = Kaminari.paginate_array(News.published).page(params[:page]).per(8)
    end
  end

  def show
    @tags = @news.tag_counts_on(:news_tags)
    @news = News.find(params[:id])
    if @news.nil? or !@news.published? then
      redirect_to news_index_url
    end
  end
end
