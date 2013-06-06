class CreativeGroupController < ApplicationController
  def index
    year = params[:year] || Time.now.year
    @cg = CreativeGroup.where(year: year)
    @year = year unless year == Time.now.year
  end
  
  def show
    @creative = CreativeGroup.find(params[:id])
  end
end
