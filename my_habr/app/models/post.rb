class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  # has_and_belongs_to_many :categories
  has_many :categories_posts
  has_many :categories, through: :categories_posts
  has_many :tags_posts
  has_many :subscriptions_posts
  has_many :subscribers, through: :subscriptions_posts, source: :user
  has_many :tags, through: :tags_posts
  validates :title, :body, :user, presence: true
  validates :title, length: {minimum: 2}

  scope :reverse_order, -> { order(created_at: :desc) }
  scope :published, -> {where(published: true)}
  scope :unpublished, -> {where(published: false)}
  scope :owner, ->(user) {where(user: user)}
  scope :moderation, -> {where(moderated: false, published: true)}
  scope :moderated, -> {where(moderated: true)}

  def categories_titles
    categories.pluck(:name).join(', ')
  end


end
