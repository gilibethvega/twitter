class AddRetweetIdToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :retweet_id, :integer, :default => nil
  end
end
