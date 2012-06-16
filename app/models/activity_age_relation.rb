# -*- coding: utf-8 -*-
class ActivityAgeRelation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :age_tag

  validates :activity, :age_tag, presence: true

  after_create :overall_age
  after_update :overall_age
  after_destroy :overall_age

  def overall_age
    activity.update_attribute(:age,
                    "#{activity.age_tags.minimum(:start_year)} — #{activity.age_tags.maximum(:end_year)}")
  end
end
