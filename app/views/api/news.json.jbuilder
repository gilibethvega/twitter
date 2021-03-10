json.array! @tweets do |tweet|
    json.id tweet.id
    json.content tweet.content
    json.user_id tweet.user_id
    json.like_count tweet.like_count
    json.retweets_count tweet.retweet_count
    json.rewtitted_from tweet.retweet_id
end