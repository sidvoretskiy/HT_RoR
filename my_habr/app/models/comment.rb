class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, :post, :user, presence: true
end
