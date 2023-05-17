# app/models/blog_post.rb
class BlogPost < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  def likes_ratio
    total_votes = likes_count + dislikes_count
    total_votes.zero? ? 0.0 : likes_count.to_f / total_votes * 100
  end

  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def self.search(query)
    where("title LIKE ?", "%#{query}%")
  end

  def likes_count
    read_attribute(:likes_count)
  end

  def dislikes_count
    read_attribute(:dislikes_count)
  end

  def increment_likes_count
    increment!(:likes_count)
  end

  def increment_dislikes_count
    increment!(:dislikes_count)
  end

  def decrement_likes_count
    decrement!(:likes_count)
  end

  def decrement_dislikes_count
    decrement!(:dislikes_count)
  end
end
