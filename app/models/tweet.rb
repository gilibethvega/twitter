class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :source_tweet, optional: true, inverse_of: :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'
  has_many :retweets, inverse_of: :source_tweet, class_name: 'Tweet', foreign_key: 'retweet_id'
  has_many :like, dependent: :destroy
  
  validates_length_of :content, :within => 1..140, :too_long => "can't be over 140 characters", :too_short => "can't be blank"
  # validates :retweet_id, uniqueness: { scope: :user_id }
  scope :tweets_for_me, -> (user) { where(user_id: user.friends.pluck(:friend_id).push(user.id)) }

  def content
    if source_tweet
      'RT @'+ (source_tweet.user).to_s + ': ' + source_tweet.content.to_s
    else
      super
    end 
  end
 
  def retweet_count
    Tweet.where.not(retweet_id: nil).where(retweet_id: self.id).count
  end

  def retweeted?(user)
    !!self.retweets.find{|tweet| tweet.user_id == user.id}
  end
  def liked?(user)
    !!self.like.find{|like| like.user_id == user.id}
  end
  def remove_like(user)
    Like.where(user: user, tweet:self).first.destroy
  end
  def add_like(user)
    Like.create(user: user, tweet:self)
  end
  def like_count
    Like.where(tweet_id: id).pluck(:tweet_id).count
  end
end
