class ArticleObserver < ActiveRecord::Observer
  def after_create(article)
    if article.published
      publish(article)
    end
  end

  def after_update(article)
    if article.published and !article.changes[:published].nil?
      publish(article)
    end
  end

  def publish(article)
    unless FbPage.first.nil? then
      page = FbGraph::Page.new(FbPage.first.identifier, :access_token => FbPage.first.token)
      pic = (article.picture) ? "http://bright-people.ru"+article.picture.url(:medium).split('?')[0].to_s : nil
      page.feed!(:message => article.title,
        :link => "bright-people.ru/articles/"+article.id.to_s,
        :picture => pic
      )
    end
  end
end
