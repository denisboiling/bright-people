class ArticleObserver < ActiveRecord::Observer
  include ActionView::Helpers::UrlHelper
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
    unless FbPage.first.nil?
      page = FbGraph::Page.new(FbPage.first.identifier, :access_token => FbPage.first.token)
      pic = (article.picture) ? "http://bright-people.ru"+article.picture.url(:medium).split('?')[0].to_s : nil
      page.feed!(:message => article.title,
        :link => "bright-people.ru/articles/"+article.id.to_s,
        :picture => pic
      )
    end
    unless VkPage.first.nil?
      vk = VkPage.first
      system("php -f public/vk.sample.php '#{vk.login}' '#{vk.password}' '#{vk.public_url}' '#{vk.public_id}' 'http://bp.balticit.ru/articles/#{article.id}' '#{article.title}'")
    end
  end
end
