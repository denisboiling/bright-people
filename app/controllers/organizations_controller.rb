class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find(params[:id])
    @activity_addresses = (Activity.where(:organization_id => params[:id], :published => true).map(&:address).map {|o| o.split(/; |;/)}).join(';').split(';').uniq
    @activity_addresses.delete_at(@activity_addresses.index(@organization.address)) unless @activity_addresses.index(@organization.address).nil?
  end
end
