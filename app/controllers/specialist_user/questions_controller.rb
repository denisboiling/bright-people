# -*- coding: utf-8 -*-
class SpecialistUser::QuestionsController < SpecialistUser::BaseController
  before_filter :load_object, except: :index

  def index
    @questions = current_user.questions.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  # OPTIMIZE: maybe...
  def update
    unless @question.publish
      @question.update_attribute(:category, QuestionCategory.find(params[:question_category_id]))
      @question_comment = @question.comments.build(params[:comment])
      @question_comment.user = current_user
      if @question_comment.save
        flash[:notice] = 'Ваш ответ сохранен'
        redirect_to specialist_user_questions_path
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
