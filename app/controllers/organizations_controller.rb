class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
    else
    end
  end
end
