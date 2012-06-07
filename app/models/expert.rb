class Expert < ActiveRecord::Base
  attr_accessible :name, :description, :photo

  has_many :activity_approvals
  has_many :approved, through: :activity_approvals, class_name: 'Activity'

  has_attached_file :photo,
                    styles: { medium: "300x300>", thumb: '125x125' },
                    path: ":rails_root/public/system/experts/:attachment/:id/:style/:filename",
                    url: "/system/experts/:attachment/:id/:style/:filename",
                    default_style: :thumb

  validates :name, :description, presence: true
  validates_attachment_presence :photo

  def mark
    activity_approvals.count
  end
  
  def prev
    Expert.all.split(self).first.last
  end
  
  def next
    Expert.all.split(self).last.first
  end
  
  # stub method, should be replaced
  def mentions
    0
  end
  
  class << self
    def for_main
      self.random(5)
    end
  end
end
