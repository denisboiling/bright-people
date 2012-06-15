class ArticlesController < ApplicationController
  before_filter :load_object, only: :show
  before_filter :check_permission, only: :show

  def tag
    @article_tag_name = params[:id]
    @articles = Article.tagged_with(params[:id])
    render 'article_tags/show'
  end

  # OPTIMIZE: brrr
  def index
    @categories = ArticleCategory.all

    sort = params[:sort]
    sort ||= 'created_at'

    category = params[:category]
    cat_id = ArticleCategory.find_by_title(params[:category]).id if !category.nil? and !category.empty?
    cat_id ||= 0
    @articles = Article.published.order(sort)
    @articles = @articles.where(article_category_id: cat_id) if cat_id != 0
    @articles = @articles.page(params[:page]).per(5)
    
    r = ( category.nil? or category.empty? ) ? false : true
    render partial: 'articles_list', locals: { articles: @articles, remote: r } if params[:remote]
  end

  def show
    @tags = @article.tag_counts_on(:article_tags)
    @comments = @article.comments.top_level
  end

  private

  def check_permission
    return if current_admin_user
    redirect_to root_path unless @article.published?
  end

  def load_object
    @article = Article.find(params[:id])
  end
end
