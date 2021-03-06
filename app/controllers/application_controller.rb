class ApplicationController < ActionController::Base
    def hashtag_arr
        tweets = Tweet.all
        new_array = []
        tweets.each do |tweet|
        count_word = 0
        key_number = 0
        hashtag = ""
        validate = false
        tweet.content.split(" ").each do |word|
            count_word += 1
            if word.start_with?("<")
            key_number = count_word
            hashtag = word
            validate = true
            elsif key_number+1 == count_word && validate
            new_word = word.sub('/', '/find_tweets/')
            hashtag += " #{new_word}"
            new_array.push(hashtag)
            end
        end
        end
        return new_array
    end
end
