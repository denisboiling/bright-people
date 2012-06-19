# -*- coding: utf-8 -*-
class SearchesController < ApplicationController
  def show
    
    range = case params[:category]
      when "Москва для детей"
        [Activity]
      when "Журнал"
        [Article]
      when "Конкурсы"
        [Contest]
      when "Экспертный совет"
        [Sponsor]
      when "Спецпроекты"
        [SpecialProject]
      else
        [Activity, Article, Sponsor, SpecialProject, Contest]
    end
    @results = ThinkingSphinx.search(params[:q], star: true, classes: range)
    @results = @results.page(params[:page]) if params[:page]
    render partial: 'searches/result', locals: { results: @results } if params[:remote]
  end
end
