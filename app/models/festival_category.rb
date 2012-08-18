class FestivalCategory < ActiveRecord::Base
  include Hierarchy
  attr_accessible :title, :path

  before_destroy :destroy_children

  has_many :gallery_photos

  validates :title, presence: true, uniqueness: true

  def photos
    if top_level?
      photos = gallery_photos.published
      children.each do |child|
        photos += child.gallery_photos.published
      end
      photos
    else
      gallery_photos.published
    end
  end

  private
  def destroy_children
    if top_level?
      children.map &:destroy
    end
  end
end
