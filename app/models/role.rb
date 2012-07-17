class Role < ActiveRecord::Base
  has_many :users
  has_many :admin_users

  class << self
    def user; self.find_by_name('user'); end
    def expert; self.find_by_name('expert'); end
    def manager; self.find_by_name('manager'); end

    def user_sets
      where(name: %w(user expert manager)).map {|r| [I18n.t(r.name), r.id]}
    end
  end
end
