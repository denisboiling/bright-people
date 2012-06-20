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
    page = FbGraph::Page.new(FbPage.first.identifier, :access_token => FbPage.first.token)
    pic = (article.picture) ? "http://bp.balticit.ru"+article.picture.url(:medium).split('?')[0].to_s : nil
    page.feed!(:message => article.title,
      :link => "bp.balticit.ru/articles/"+article.id.to_s,
      :picture => pic
    )
  end
end
