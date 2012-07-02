class VkPagesController < ApplicationController
  def auth
    @vk_page = VkPage.first
  end

  def create_vk_page
    @vk_page = VkPage.first
    @vk_page.login = params[:vk_page][:login]
    @vk_page.password = params[:vk_page][:password]
    @vk_page.public_url = params[:vk_page][:public_url]
    @vk_page.public_id = params[:vk_page][:public_id]
    @vk_page.save
    redirect_to root_path
  end
end
