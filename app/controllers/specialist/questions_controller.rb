# -*- coding: utf-8 -*-
class Specialist::QuestionsController < Specialist::BaseController
  before_filter :load_object, except: :index

  def index
    @questions = current_user.questions.page(params[:page]).per(10)
  end

  def show
  end

  # OPTIMIZE: maybe...
  def update
    unless @question.publish
      @question.update_attribute(:category, QuestionCategory.find(params[:question_category_id]))
      @question_comment = @question.comments.build(params[:question_comment])
      @question_comment.user = current_user
      @question_comment.question = @question
      if @question_comment.save
        flash[:notice] = 'Ваш ответ сохранен'
        redirect_to specialist_questions_path
      else
        render :show
      end
    end
  end

  private

  def load_object
    @question = Question.find(params[:id])
  end

end
