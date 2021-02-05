class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #relacion con tweets
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  def to_s
    username
  end
end

