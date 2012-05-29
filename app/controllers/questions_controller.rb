class QuestionsController < ApplicationController
  before_filter :load_object

  def show
  end

  private

  def load_object
    @question = Question.find(params[:id])
  end
end
