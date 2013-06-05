class Page < ActiveRecord::Base
  attr_accessible :permalink, :text, :year

  # find page by permalink
  def self.as(_permalink)
    find_by_permalink(_permalink)
  end
end
