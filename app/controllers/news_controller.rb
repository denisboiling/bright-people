class NewsController < ApplicationController
  def index
    @news = Kaminari.paginate_array(News.published).page(params[:page]).per(8)
  end

  def show
    @news = News.find(params[:id])
    if @news.nil? or !@news.published? then
      redirect_to news_index_url
    end
  end
end
