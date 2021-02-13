class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def tweet_likes
    Like.joins(:tweet).where(tweet_id: id)
  end 
  def users_whit_like
    Like.joins(:user).where(user_id: user.id).distinct.pluck(:photo_url).join(', ')
  end
end
