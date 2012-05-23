class Role < ActiveRecord::Base
  has_many :users
  has_many :admin_users

  class << self
    def user; self.find_by_name('user'); end
  end
end
