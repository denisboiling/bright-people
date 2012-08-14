class PhotosController < ApplicationController
  def index
    @photos = GalleryPhoto.all
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
end
