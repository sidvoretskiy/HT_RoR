class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :profile
  has_many :posts
  has_many :comments
  has_many :subscriptions_posts
  has_many :subscriptions, through: :subscriptions_posts, source: :post
end
