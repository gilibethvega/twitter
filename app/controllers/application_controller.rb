class ApplicationController < ActionController::Base
	def hashtag_array
		new_array_hashtag = []
		tweets = Tweet.all
		tweets.each do |tweet|
			n_word = 0
			key_number = 0
			hashtag = ""
			validate = false
			tweet.content.split(" ").each do |word|
				n_word += 1
				if word.start_with?("<")
					key_number = n_word
					hashtag = word
					validate = true
				elsif key_number+1 == n_word && validate
					new_word = word.sub('/', '/find_tweets/')
					hashtag += " #{new_word}"
					new_array_hashtag.push(hashtag)
				end
			end
		end
		return new_array_hashtag
	end
end
