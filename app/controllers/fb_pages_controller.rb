class FbPagesController < ApplicationController
  
  def fb_auth
    fb_auth = FbGraph::Auth.new '245615425549849', '17849468bffdd53974e21bac98b397e9', redirect_uri: 'http://bp.balticit.ru/fb_pages'
    client = fb_auth.client
    redirect_to client.authorization_uri(
      :scope => [:manage_pages, :publish_stream, :offline_access]
    )
  end

  def fb_pages
    fb_auth = FbGraph::Auth.new '245615425549849', '17849468bffdd53974e21bac98b397e9', redirect_uri: 'http://bp.balticit.ru/fb_pages'
    client = fb_auth.client
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body
    owner = FbGraph::User.me(access_token)
    pages = owner.accounts
    page = pages.detect do |page|
      page.name == 'Mytestpage'
    end
    @p = FbPage.find_by_identifier(page.identifier)
    @p ||= FbPage.new
    @p.identifier = page.identifier
    @p.token = page.access_token
    @p.save
  end
end
