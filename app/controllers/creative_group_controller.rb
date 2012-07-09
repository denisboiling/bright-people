class CreativeGroupController < ApplicationController
  def index
    @cg = CreativeGroup.all
  end
end
