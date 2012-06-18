class Contest < ActiveRecord::Base
  belongs_to :category, class_name: 'ContestCategory'
  has_many :memberships, class_name: 'ContestMembership'
  has_many :votes, class_name: 'ContestVote'

  attr_accessible :name, :started_at, :ended_at, :description, :picture,
                  :category_id, :rules, :active, as: :admin

  validates :name, :started_at, :ended_at, :description, :rules ,presence: true

  has_attached_file :picture, styles: { big: "840x270^#", medium: "300x300^#", thumb: "325x100^#" },
                              path: ":rails_root/public/system/contests/:attachment/:id/:style/:filename",
                              url: "/system/contests/:attachment/:id/:style/:filename",
                              default_style: :thumb

  define_index do
    indexes name, sortable: true
    indexes description
    indexes memberships.description, as: :membership_description
  end

  # to fit common views
  def title
    name
  end

  # def active?
  #   active == true
  #   # now = DateTime.now
  #   # (started_at < now) and (now < ended_at)
  # end

  class << self
    def for_main
      where(active: true).order('created_at DESC').first
    end
  end
end
