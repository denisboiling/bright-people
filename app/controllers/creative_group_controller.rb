class CreativeGroupController < ApplicationController
  def index
    @cg = CreativeGroup.all
  end
  
  def show
    @creative = CreativeGroup.find(params[:id])
  end
end
