class Article < ActiveRecord::Base
  validates :title, presence: true,
                    length: {minimum: 5}

  validates :slug, presence: true,
                   length: {minimum: 5}

  validate :ensure_slug_uniqueness

  def to_param
    self.slug
  end

  protected

  # validate
  def ensure_slug_uniqueness

    # we also want to ensure the slug is not blank
    if self.slug.blank?
      errors.add(:slug, "can't be blank")
    end

    # if this is a new post, the id is nil
    # otherwise, the slug should point to this post's id
    unless Slug[self.slug].nil? || Slug[self.slug] == self.id.to_s
      errors.add(:slug, "is already taken")
    end
  end
end
