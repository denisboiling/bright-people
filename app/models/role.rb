class Role < ActiveRecord::Base
  has_many :users
  has_many :admin_users

  attr_accessible :id, :name

  class << self
    def user; self.find_by_name('user'); end
    def expert; self.find_by_name('expert'); end
    def manager; self.find_by_name('manager'); end
    def author; self.find_by_name('author'); end
    def photographer; self.find_by_name('photographer'); end
    def main_photographer; self.find_by_name('main_photographer'); end

    def user_sets
      where('name NOT IN (?)', %w(author )).map {|r| [I18n.t(r.name), r.id]}
    end

  end
end
