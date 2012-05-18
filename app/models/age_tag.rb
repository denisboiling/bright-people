# encoding: utf-8

class AgeTag < ActiveRecord::Base
  validates :start_year, :end_year, presence: true
  
  has_many :activities
  
  def title
    "#{start_year}-#{end_year} лет"
  end
end
