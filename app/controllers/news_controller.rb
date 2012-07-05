class NewsController < ApplicationController
  def index
    @news = Kaminari.paginate_array(News.all).page(params[:page]).per(8)
  end

  def show
    @news = News.find(params[:id])
  end
end
