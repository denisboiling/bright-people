class SocialPostObserver < ActiveRecord::Observer
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
      pic = model.photo ? "http://images.bright-people.ru" + model.photo.url(:medium, false) : nil
      page.feed!(:message => model.title,
                 :link => "http://bright-people.ru/#{model.class.name.downcase.pluralize}/" + model.id.to_s,
                 :picture => pic
                )
    end
  end

end
