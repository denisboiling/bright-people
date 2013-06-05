class PagesController < HighVoltage::PagesController
  
  before_filter :set_page
  
  protected
  
  def set_page
    permlink = params[:id]
    year = params[:year]
    if year.present?
      @page = Page.where(year: params[:year]).as(permlink)
    else
      @page = Page.where(year: Time.now.year ).as(permlink)
      @page ||= Page.as(permlink)
    end
  end
  
end
