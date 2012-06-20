# -*- coding: utf-8 -*-
module ActiveAdmin::ViewHelpers
  def age_collection(type, start_age=0, end_age=16)
    word = type == :start ? 'от ' : 'до '
    (0..16).map {|a| [ word + I18n.t(:age, count: a), a]}
  end
end
