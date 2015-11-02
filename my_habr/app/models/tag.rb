class Tag < ActiveRecord::Base
  has_many :tags_posts
  has_many :post, through: :tags_posts
end
