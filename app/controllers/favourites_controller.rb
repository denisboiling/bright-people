class FavouritesController < ApplicationController
  def index
    if current_user
      @favourites = Favourite.all(conditions: { user_id: current_user.id })
    end
  end

  def create
    @favourite = Favourite.new
    @favourite.user_id = current_user.id
    @favourite.url = params[:url]
    @favourite.save
    render nothing: true
  end

  def destroy
    Favourite.find(params[:id]).destroy
    redirect_to favourites_path
  end
end
