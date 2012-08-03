class SocialPostObserver < ActiveRecord::Observer
  include ActionView::Helpers::TextHelper
  # TODO: rewrite this shit!!!!
  observe :article, :news

  include ActionView::Helpers::UrlHelper

  def after_create(model)
    SocialPostObserver::publish(model) if model.published?
  end

  def after_update(model)
    if model.published? and !model.posted
      SocialPostObserver::publish(model)
    end
  end

  def self.publish(model)
    model.posted = true
    model.save!
    unless FbPage.first.nil? or FbPage.first.identifier.nil? or FbPage.first.token.nil?
      page = FbGraph::Page.new(FbPage.first.identifier, :access_token => FbPage.first.token)
      description = Sanitize.clean(model.short_description)
      pic = model.photo ? "http://images.bright-people.ru" + model.photo.url(:medium, false) : nil
      page.feed!(:message => model.title,
                 :link => "#{Rails.application.config.host_name}/#{model.class.name.downcase.pluralize}/" + model.id.to_s,
                 :picture => pic,
                 :description => description
                )
    end
    unless VkPage.first.nil? or VkPage.first.access_token.nil?
      standalone = VK::Standalone.new :app_id => '3051096'
      standalone.wall.post(owner_id: "#{Rails.application.config.vk_public}", attachments: "#{Rails.application.config.host_name}/#{model.class.name.downcase.pluralize}/" + model.id.to_s, from_group: 1, access_token: VkPage.first.access_token)
    end
  end

end
