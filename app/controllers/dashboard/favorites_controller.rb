class Dashboard::FavoritesController < Dashboard::BaseController
  def index
    @favourites = current_user.favourites
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
