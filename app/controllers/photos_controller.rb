class PhotosController < ApplicationController
  def index
    @photos = GalleryPhoto.all
  end
end
