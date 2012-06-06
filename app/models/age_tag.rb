# -*- coding: utf-8 -*-
class AgeTag < ActiveRecord::Base
  validates :start_year, :end_year, presence: true

  has_many :activity_age_relations
  has_many :activities, through: :activity_age_relations

  def title
    "#{start_year}-#{end_year} лет"
  end
end
