class QuestionsController < ApplicationController
  before_filter :load_object

  def show
    @comments = @question.comments.top_level
  end

  private

  def load_object
    @question = Question.find(params[:id])
  end
end
