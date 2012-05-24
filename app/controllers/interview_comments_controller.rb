class InterviewCommentsController < ApplicationController
  def create
    @interview_comment = InterviewComment.new
    @interview_comment.author = "Test Author"
    @interview_comment.content = params[:content]
    @interview_comment.interview = Interview.find(params[:interview_id])
    @interview_comment.parent = (params[:parent_comment_id] == "0") ?
                               nil :
                               InterviewComment.find(params[:parent_comment_id])
    @interview_comment.save
    @interview = Interview.find(params[:interview_id])
    @interview_tags = @interview.tag_counts_on(:interview_tags)
    @interview_comments = @interview.interview_comments.select(&:top_level?)
    render 'interviews/show'
  end
end
