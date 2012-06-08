class Role < ActiveRecord::Base
  has_many :users
  has_many :admin_users

  class << self
    def user; self.find_by_name('user'); end
    def expert; self.find_by_name('expert'); end
  end
end
