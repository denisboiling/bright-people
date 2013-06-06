class CreativeGroupController < ApplicationController
  def index
    year = params[:year]
    @cg = if year
      CreativeGroup.where(year: year)
    else
      CreativeGroup.where(year: Time.now.year)
    end
  end
  
  def show
    @creative = CreativeGroup.find(params[:id])
  end
end
