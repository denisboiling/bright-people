class SearchesController < ApplicationController
  def show
    @results = ThinkingSphinx.search(params[:q], star: true, classes: [Activity, Organization])
  end
end
