class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friends, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy
  def to_s
    username
  end
  def users_followed
    arr_ids = self.friends.pluck(:friend_id)
    User.find(arr_ids)
  end

  def is_following?(user)
    users_followed.include? (user)
  end

end

