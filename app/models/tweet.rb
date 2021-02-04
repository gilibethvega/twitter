class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :source_tweet, optional: true, inverse_of: :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'
  has_many :retweets, inverse_of: :source_tweet, class_name: 'Tweet', foreign_key: 'retweet_id'
  
  validates :content, absence: true, if: :source_tweet, length: { maximum: 140 }
  # validates :retweet_id, uniqueness: { scope: :user_id }

  def content
    if source_tweet
      source_tweet.content
    else
      super
    end
  end
  
  def content=(content)
    if source_tweet
      raise 'retweets cannot have content'
    else
      super
    end
  end
  
  # depe

  def n_retweet
    Tweet.where.not(retweet_id: nil).where(retweet_id: self.retweet_id).count
  end

  def retweeted?(user)
    !!self.retweets.find{|tweet| tweet.user_id == user.id}
  end
    
end
