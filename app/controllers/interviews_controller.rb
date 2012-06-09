class InterviewsController < ApplicationController
  def tag
    @interview_tag_name = params[:id]
    @interviews = Interview.tagged_with(params[:id])
    render 'interview_tags/show'
  end

  def index
    @interviews = Interview.all

    sort = params[:sort]
    sort ||= 'created_at'

    @interviews = Interview.order(sort)
    @interviews = @interviews.page(params[:page]).per(5)

    render partial: 'interviews_list', locals: { interviews: @interviews } if params[:remote]
  end

  def show
    @interview = Interview.find(params[:id])
    @tags = @interview.tag_counts_on(:interview_tags)
    @comments = @interview.comments.top_level
  end
end
