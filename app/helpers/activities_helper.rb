# -*- coding: utf-8 -*-
module ActivitiesHelper
  # return a schedule time with format
  def schedule_time(_time)
    "#{_time['start']}—#{_time['end']}"
  end
end
