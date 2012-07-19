# -*- coding: utf-8 -*-
class Dashboard::ActivitiesController < Dashboard::BaseController
  load_and_authorize_resource :dashboard_activity, class: false
  before_filter :load_object

  def show
  end

  def update
    if @activity.update_attributes(params[:activity])
      redirect_to dashboard_activity_path, notice: 'Кружок успешно обновлен'
    else
      flash[:error] = 'Что то пошло не так, есть ошибки'
      render :show
    end
  end

  def destroy_teacher
    @activity.teachers.find(params[:id]).destroy
    render nothing: true
  end

  private

  def load_object
    @activity = current_user.activity
  end
end
