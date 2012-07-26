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
    if model.published? and !model.changes[:published].nil?
      publish(model)
    end
  end

  def publish(model)
    unless FbPage.first.nil?
      page = FbGraph::Page.new(FbPage.first.identifier, :access_token => FbPage.first.token)
      description = model.class.name == 'Article' ? model.short_description : model.content
      pic = model.photo ? "http://images.bright-people.ru" + model.photo.url(:medium, false) : nil
      page.feed!(:message => model.title,
                 :link => "http://bright-people.ru/#{model.class.name.downcase.pluralize}/" + model.id.to_s,
                 :picture => pic,
                 :description => description
                )
    end
    unless VkPage.first.nil?
      standalone = VK::Standalone.new :app_id => '3051096'
      # TODO !!! change owner_id and attachment when deploying to production!
      standalone.wall.post(owner_id: '-40194424', attachments: "#{Rails.application.config.host_name}/#{model.class.name.downcase.pluralize}/" + model.id.to_s, from_group: 1, access_token: VkPage.first.access_token)
    end
  end

end
