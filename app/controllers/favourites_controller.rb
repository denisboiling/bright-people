class FavouritesController < ApplicationController
  load_and_authorize_resource :dashboard, class: false
  
  def index
    @favourites = Favourite.all(conditions: { user_id: current_user.id })
  end

  def create
    @favourite = Favourite.new
    @favourite.user_id = current_user.id
    @favourite.relation_id = params[:id]
    @favourite.relation_type = params[:type]
    @favourite.save!
    render json: { id: @favourite.id }
  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.destroy if favourite.user == current_user
    redirect_to favourites_path
  end
end
