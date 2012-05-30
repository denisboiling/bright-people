class CommentsController < ApplicationController

  # OPTIMIZE: bugagagga, this is tolsto
  def create
    return unless Comment.possible_relations.include?(params[:relation_type])
    comment = current_user.comments.build
    if params[:parent_id]
      parent_comment = Comment.find(params[:parent_id])
      comment.parent = parent_comment
    end
    comment.text = params[:text]
    comment.relation_type = params[:relation_type]
    comment.relation_id = params[:relation_id]
    comment.save
    render partial: 'shared/comment', locals: {comment: comment}
  end
end
