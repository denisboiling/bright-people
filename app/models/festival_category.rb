class FestivalCategory < ActiveRecord::Base
  include Hierarchy
  attr_accessible :title, :path

  before_destroy :destroy_children

  has_many :gallery_photos

  validates :title, presence: true, uniqueness: true

  def photos
    if top_level?
      GalleryPhoto.where("festival_category_id IN (?)", [ id ] + children.map(&:id)).published
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
