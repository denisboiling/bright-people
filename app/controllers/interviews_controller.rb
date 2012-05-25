class InterviewsController < ApplicationController
  def tag
    @interview_tag_name = params[:id]
    @interviews = Interview.tagged_with(params[:id])
    render 'interview_tags/show'
  end

  def index
    @interviews = Interview.all
  end

  def show
    @interview = Interview.find(params[:id])
    @tags = @interview.tag_counts_on(:interview_tags)
    @comments = @interview.comments.select(&:top_level?)
  end
end
