class Page < ActiveRecord::Base
  attr_accessible :permalink, :text

  # find page by permalink
  def self.as(_permalink)
    find_by_permalink(_permalink)
  end
end
