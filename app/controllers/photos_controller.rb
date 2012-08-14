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

  private

  # OPTIMIZE
  def search_params
    @photographers = params["photographers"].split(',') if params["photographers"].present?
    params['hour']   ||= 10
    params['minute'] ||= 00
    @time = Time.zone.parse("2012-09-18 #{params['hour']}:#{params['minute']}:00").to_s(:db)
  end
end
