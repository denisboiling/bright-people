class CreativeGroup < ActiveRecord::Base
  default_scope :order => 'position ASC'

  attr_accessible :name, :description, :profession, :avatar, :position, :year

  has_attached_file :avatar, styles: { medium: "300x300^#", thumb: "125x125^#" },
                             path: ":rails_root/public/system/creative_group/:attachment/:id/:style/:filename",
                             url: "/system/creative_group/:attachment/:id/:style/:filename",
                             default_style: :thumb, default_url: 'loading.gif'

  validates :name, :description, :profession, :avatar, presence: true

  def prev_creative
    CreativeGroup.split(self).first.last
  end

  def next_creative
    CreativeGroup.split(self).last.first
  end

end
