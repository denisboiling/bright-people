class ChangeVkPage < ActiveRecord::Migration
  def change
    rename_column :vk_pages, :login, :access_token
    remove_column :vk_pages, :password
    remove_column :vk_pages, :public_url
    remove_column :vk_pages, :public_id
  end
end
