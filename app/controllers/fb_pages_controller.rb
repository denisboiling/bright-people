# -*- coding: utf-8 -*-
class FbPagesController < ApplicationController
  
  def fb_auth
    authorize! :manage, :social
    fb_auth = FbGraph::Auth.new "#{Rails.application.config.fb_app_id}", "#{Rails.application.config.fb_app_secret}",
                                  redirect_uri: "#{Rails.application.config.host_name}/fb_pages"
    client = fb_auth.client
    redirect_to client.authorization_uri(
      :scope => [:manage_pages, :publish_stream, :offline_access]
    )
  end

  def fb_pages
    authorize! :manage, :social
    fb_auth = FbGraph::Auth.new "#{Rails.application.config.fb_app_id}", "#{Rails.application.config.fb_app_secret}",
                                  redirect_uri: "#{Rails.application.config.host_name}/fb_pages"
    client = fb_auth.client
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body
    fb_auth.exchange_token! access_token
    owner = FbGraph::User.me(access_token)
    pages = owner.accounts
    page = pages.detect do |page|
      page.name == "#{Rails.application.config.fb_page_name}"
    end
    if(!page.nil?)
      FbPage.all.map(&:destroy)
      p = FbPage.new
      p.identifier = page.identifier
      p.token = page.access_token
      p.save
    end
  end
end
