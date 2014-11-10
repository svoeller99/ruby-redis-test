class ArticleObserver < ActiveRecord::Observer
  def after_save(article)
    Slug[article.slug] = article.id.to_s
    return true
  end

  def after_destroy(article)
    Slug.destroy(article.id)
    return true
  end
end