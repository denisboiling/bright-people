class CrewController < ApplicationController
  def index
    @crew = Kaminari.paginate_array(Crew.all).page(params[:page]).per(12)
  end
end
