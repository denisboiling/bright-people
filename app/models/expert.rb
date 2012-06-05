class Expert < ActiveRecord::Base
  attr_accessible :name, :description, :photo

  has_attached_file :photo,
                    styles: { medium: "300x300>", thumb: '125x125' },
                    path: ":rails_root/public/system/experts/:attachment/:id/:style/:filename",
                    url: "/system/experts/:attachment/:id/:style/:filename",
                    default_style: :thumb

  validates :name, :description, presence: true
  validates_attachment_presence :photo

  class << self
    def for_main
      self.random(5)
    end
  end
end
