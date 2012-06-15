class SpecialProjectsController < ApplicationController
  def tag
    @special_project_tag_name = params[:id]
    @special_projects = SpecialProject.tagged_with(params[:id])
    render 'special_project_tags/show'
  end

  def index
    @special_projects = SpecialProject.scoped
    @special_projects =
      case params[:sort]
      when 'created'
        @special_projects.order('created_at DESC')
      when 'comments_count'
        # TODO
        @special_projects
      else
        @special_projects
      end
    @special_projects = @special_projects.page(params[:page]).per(15)
  end

  def show
    @special_project = SpecialProject.find(params[:id])
    @tags = @special_project.tag_counts_on(:special_project_tags)
    @comments = @special_project.comments.top_level
  end
end
