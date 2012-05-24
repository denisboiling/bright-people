class InterviewsController < ApplicationController
   def tag
    @interview_tag_name = params[:id]
    @interviews = Interview.tagged_with(params[:id])
    render 'interviews_tags/show'
  end

  def index
    @interviews = Interview.all
  end

  def show
    @interview = Interview.find(params[:id])
    @interview_tags = @interview.tag_counts_on(:article_tags)
    @interview_comments = @interview.interview_comments.select(&:top_level?)
  end
end
