class CommentsController < ApplicationController
  def create
    @comment = Comment.create! user: current_user, content: params[:content],
                               article_id: params[:article_id],
                               interview_id: params[:interview_id],
                               parent: Comment.where(id: params[:parent_comment_id]).first
    render partial: 'comments/comment', locals: { comment: @comment }
  end
end
