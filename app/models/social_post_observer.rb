class SocialPostObserver < ActiveRecord::Observer
  include ActionView::Helpers::TextHelper
  # TODO: rewrite this shit!!!!
  observe :article, :news

  include ActionView::Helpers::UrlHelper

  def after_create(model)
    publish(model) if model.published?
  end

  # TODO: News or Artilce has't field published, replace this shit
  def after_update(model)
    if model.published? and !model.is_posted
      publish(model)
    end
  end

  def publish(model)
    unless FbPage.first.nil?
      page = FbGraph::Page.new(FbPage.first.identifier, :access_token => FbPage.first.token)
      description = model.class.name == 'Article' ? model.short_description : model.content
      pic = model.photo ? "http://images.bright-people.ru" + model.photo.url(:medium, false) : nil
      page.feed!(:message => model.title,
                 :link => "#{Rails.application.config.host_name}/#{model.class.name.downcase.pluralize}/" + model.id.to_s,
                 :picture => pic,
                 :description => description
                )
    end
    unless VkPage.first.nil?
      standalone = VK::Standalone.new :app_id => '3051096'
      standalone.wall.post(owner_id: "#{Rails.application.config.vk_public}", attachments: "#{Rails.application.config.host_name}/#{model.class.name.downcase.pluralize}/" + model.id.to_s, from_group: 1, access_token: VkPage.first.access_token)
      model.is_posted = true
      model.save
    end
  end

end
