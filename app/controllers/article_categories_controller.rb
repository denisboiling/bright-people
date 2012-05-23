class ArticleCategoriesController < ApplicationController
  def show
    @category = ArticleCategory.find(params[:id])
    @articles = Article.all(:conditions => { :article_category_id => @category.id })
  end
end
