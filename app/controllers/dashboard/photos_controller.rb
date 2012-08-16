class Dashboard::PhotosController < Dashboard::BaseController
  def index
  end

  def create
    @photo = GalleryPhoto.new(params[:gallery_photo])
    @photo.photo = params[:photo]
    if @photo.save
      respond_to do |format|
	format.html {
	  render :json => [@photo.to_jq_upload].to_json,
	  :content_type => 'text/html',
	  :layout => false
	}
	format.json {
	  render :json => [@photo.to_jq_upload].to_json
	}
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @picture = GalleryPhoto.find(params[:id])
    @picture.destroy
    render :json => true
  end

end
