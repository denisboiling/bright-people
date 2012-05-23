class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find_by_activity_id(params[:activity_id])
  end
end
