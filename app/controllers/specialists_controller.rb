# -*- coding: utf-8 -*-
class SpecialistsController < ApplicationController
  before_filter :load_object, except: :index

  def index
    @specialists = User.specialists.page(params[:page]).per(5)
  end

  def show
    @questions = @specialist.questions.publish.page(params[:page]).per(5)
  end

  # Create question and assign it with specialist
  # TODO: create this with ajax
  def create_question
    @question = current_user.
      my_questions.new(params[:question].merge(specialist_id: @specialist.id))
    if @question.save
      flash[:notice] = 'Ваш вопрос оптавлен специалисту'
      redirect_to specialist_path
    else
      render :show
    end
  end

  private

  # Load specialist object
  def load_object
    @specialist = User.specialists.find(params[:id])
  end
end
