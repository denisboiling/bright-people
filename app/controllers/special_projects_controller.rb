class SpecialProjectsController < ApplicationController
  def tag
    @special_project_tag_name = params[:id]
    @special_projects = SpecialProject.tagged_with(params[:id])
    render 'special_project_tags/show'
  end

  def index
    @special_projects = SpecialProject.all
  end

  def show
    @special_project = SpecialProject.find(params[:id])
    @tags = @special_project.tag_counts_on(:special_project_tags)
    @comments = @special_project.comments.select(&:top_level?)
  end
end
