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

  #Указание ассоциации с определенной моделью по определенному ключу
  #has_many :subscriptions, class_name: 'User', foreig_key: :user_id, through: :subscriptions_posts
end
