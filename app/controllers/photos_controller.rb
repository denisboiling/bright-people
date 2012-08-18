class PhotosController < ApplicationController
  before_filter :search_params, only: :index

  layout "promo"

  # OPTIMIZE
  def index
    @photos = if @photographers
                GalleryPhoto.by_photograph_and_time(@photographers, @time)
              else
                GalleryPhoto.by_time(@time)
              end
    @photos = @photos.order('shot_date ASC').page(params[:page]).per(30)
    if request.xhr?
      render partial: 'photos', locals: {photos: @photos}
    end
  end

  # TODO: rewrite..berr
  def download
    arhive = GalleryPhoto.create_archive(params[:ids])
    render text: "/arhives/#{arhive.match(/(\w+\.zip)$/)[0]}"
  end

  def promo
  end

  def clock
  end

  def festival
  end

  def add_view
    photo = GalleryPhoto.find(params[:id])
    photo.views += 1
    photo.save
    respond_to do |format|
      format.json { render :json => :ok }
    end
  end

  private

  # OPTIMIZE: bbrr
  def search_params
    @photographers = params["photographers"].split(',') if params["photographers"].present?
    @time =  if params['hour'].present? || params['minute'].present?
               GalleryPhoto::FESTIVAL_START.change(hour: params['hour'], min: params['minute'])
             else
               GalleryPhoto::FESTIVAL_START
             end
  end
end
