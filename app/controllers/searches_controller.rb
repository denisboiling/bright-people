# -*- coding: utf-8 -*-
class SearchesController < ApplicationController
  def show
    
    if params[:category].nil? or params[:category].empty?
      range = [Activity, Organization, Article, Sponsor, SpecialProject, Contest]
    else 
      case params[:category]
        when "Москва для детей"
          range = [Activity]
        when "Журнал"
          range = [Article]
        when "Конкурсы"
          range = [Contest]
        when "Экспертный совет"
          range = [Sponsor]
        when "Спецпроекты"
          range = [SpecialProject]
        else range = [Activity, Organization, Article, Sponsor, SpecialProject, Contest]
      end
    end
    @results = ThinkingSphinx.search(params[:q], star: true, classes: range)
    @results = @results.page(params[:page]) if params[:page]
    @request = params[:q]
    render partial: 'searches/result', locals: { results: @results.page(params[:page] || 1) } if params[:remote]
  end
end
