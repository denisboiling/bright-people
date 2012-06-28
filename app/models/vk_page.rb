class VkPage < ActiveRecord::Base
  attr_accessible :login, :password, :public_url, :public_id
end
