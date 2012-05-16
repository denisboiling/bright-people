class Role < ActiveRecord::Base
  has_many :roles

  class << self
    def user; self.find_by_name('user'); end
  end
end
