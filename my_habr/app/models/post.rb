class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  # has_and_belongs_to_many :categories
  has_many :categories_posts
  has_many :categories, through: :categories_posts
  has_many :tags_posts
  has_many :tags, through: :tags_posts
  validates :title, :body, presence: true
  validates :title, length: { minimum: 2 }

  def categories_titles
    categories.pluck(:name).join(', ')
  end
end
