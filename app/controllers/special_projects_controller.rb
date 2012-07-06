class SpecialProjectsController < ApplicationController
  def tag
    @special_project_tag_name = params[:tag]
    @special_projects = SpecialProject.tagged_with(@special_project_tag_name)
    render 'special_project_tags/show'
  end

  def index
    # TODO: replace active link for current page
    @special_project_page = true
    @special_projects = SpecialProject.scoped
    @special_projects =
      case params[:sort]
      when 'created'
        @special_projects.order('created_at DESC')
      when 'comments_count'
        @special_projects.order('comments_count')
      else
        @special_projects
      end
    @special_projects = @special_projects.page(params[:page]).per(12)
  end

  def show
    @special_project = SpecialProject.find(params[:id])
    @tags = @special_project.tag_counts_on(:special_project_tags)
    @comments = @special_project.comments.top_level
  end
end
