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
    @photos = GalleryPhoto.by_time(Time.zone.parse('2012-08-18, 10:00:00'))
  end 

  private

  # OPTIMIZE: bbrr
  def search_params
    @photographers = params["photographers"].split(',') if params["photographers"].present?
    @time =  if params['hour'].present? || params['minute'].present?
               GalleryPhoto::FESTIVAL_START.change(hour: params['hour'], minute: params['minute'])
             else
               GalleryPhoto::FESTIVAL_START
             end
  end
end
