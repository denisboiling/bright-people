class VkPagesController < ApplicationController
  def auth
    redirect_to "http://api.vk.com/oauth/authorize?client_id=3051096&scope=wall,groups,offline&redirect_uri=http://api.vk.com/blank.html&display=popup&response_type=token"
  end

  def create_vk_page
    @vp = VkPage.first
    @vp ||= VkPage.new
    @vp.access_token = params[:access_token]
    @vp.save!
  end
end
