class PagesController < HighVoltage::PagesController
  
  before_filter :set_page
  
  protected
  
  def set_page
    permlink = params[:id]
    year = params[:year] || Time.now.year
    @page = Page.where(year: year).as(permlink)
    @page ||= Page.as(permlink)
    @year = year unless year == Time.now.year
  end
  
end
