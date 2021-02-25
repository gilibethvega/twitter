class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #relacion con tweets
  has_many :tweets, dependent: :destroy
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friend'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Friend'
  has_many :followers, through: :following_users
  def to_s
    username
  end
end

