class ArticleCommentsController < ApplicationController
  def create
    @article_comment = ArticleComment.new
    @article_comment.author = "Test Author"
    @article_comment.content = params[:content]
    @article_comment.article = Article.find(params[:article_id])
    @article_comment.parent = (params[:parent_comment_id] == "0") ?
                               nil :
                               ArticleComment.find(params[:parent_comment_id])
    @article_comment.save
    @article = Article.find(params[:article_id])
    @article_tags = @article.tag_counts_on(:article_tags)
    @article_comments = @article.article_comments.select(&:top_level?)
    render 'articles/show'
  end
end
